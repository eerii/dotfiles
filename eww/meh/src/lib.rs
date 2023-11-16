pub mod battery;
pub mod daemon;
pub mod net;
pub mod notify;
pub mod volume;

use std::{fs, path::Path};

use battery::BatteryInfo;
use const_format::concatcp;
use net::NetInfo;
use serde_json::Value;
use volume::VolumeInfo;

use ::notify::{event::EventKind, Config, Event, RecommendedWatcher, RecursiveMode, Watcher};
use clap::{Parser, Subcommand};
use futures::{
    channel::mpsc::{channel, Receiver},
    SinkExt, StreamExt,
};
use serde::{Deserialize, Serialize};

pub const DIR_FILE: &str = "/tmp/meh";
pub const OUT_FILE: &str = concatcp!(DIR_FILE, "/out");
pub const ERR_FILE: &str = concatcp!(DIR_FILE, "/err");
pub const PID_FILE: &str = concatcp!(DIR_FILE, "/pid");
pub const DATA_FILE: &str = concatcp!(DIR_FILE, "/data");

#[derive(Serialize, Parser, Debug)]
#[command(author, version, about, propagate_version = true)]
pub struct Cli {
    #[command(subcommand)]
    #[serde(skip_serializing)]
    pub command: Option<Commands>,

    #[arg(short, long, action)]
    #[serde(skip_serializing)]
    pub daemon: bool,

    #[arg(short, long, action)]
    #[serde(skip_serializing)]
    pub kill_daemon: bool,
}

#[derive(Subcommand, Debug, Serialize)]
pub enum Commands {
    Get {
        #[arg(short, long, action)]
        #[clap(group = "cmd")]
        battery: bool,

        #[arg(short, long, action)]
        #[clap(group = "cmd")]
        network: bool,

        #[arg(short, long, action)]
        #[clap(group = "cmd")]
        volume: bool,

        #[arg(short, long, action)]
        #[serde(skip_serializing)]
        monitor: bool,
    },

    Volume {
        #[arg(long)]
        #[clap(group = "volume")]
        set: Option<u32>,

        #[arg(long)]
        #[clap(group = "volume")]
        add: Option<i32>,

        #[arg(long)]
        #[clap(group = "volume")]
        sub: Option<i32>,

        #[arg(long)]
        #[clap(group = "volume")]
        mute: Option<bool>,

        #[arg(long, action)]
        #[clap(group = "volume")]
        toggle_mute: bool,
    },
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Info {
    pub battery: BatteryInfo,
    pub network: NetInfo,
    pub volume: VolumeInfo,
}

pub trait HasPrev {
    fn prev(&mut self, next: Value) -> Value;
}

pub fn write_data<T: Serialize + HasPrev>(curr: &mut T, name: &str) {
    if let Ok(s) = serde_json::to_value(&*curr) {
        if s != curr.prev(s.clone()) {
            let path = format!("{}.{}", DATA_FILE, name);
            if let Err(e) = fs::write(path.clone(), s.to_string()) {
                eprintln!("couldn't write data to {}: {}", path, e);
            }
        }
    }
}

fn async_watcher() -> ::notify::Result<(RecommendedWatcher, Receiver<::notify::Result<Event>>)> {
    let (mut tx, rx) = channel(1);

    let watcher = RecommendedWatcher::new(
        move |res| {
            futures::executor::block_on(async {
                tx.send(res).await.unwrap();
            })
        },
        Config::default(),
    )?;

    Ok((watcher, rx))
}

pub async fn async_watch<P: AsRef<Path>>(path: P, f: &dyn Fn(&str)) -> ::notify::Result<()> {
    let (mut watcher, mut rx) = async_watcher()?;
    watcher.watch(path.as_ref(), RecursiveMode::NonRecursive)?;

    while let Some(res) = rx.next().await {
        match res {
            Ok(event) => match event.kind {
                EventKind::Modify(_) => f(event.paths[0].to_str().unwrap()),
                _ => (),
            },
            Err(e) => println!("watch error: {:?}", e),
        }
    }
    Ok(())
}
