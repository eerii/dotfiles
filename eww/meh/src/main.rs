use meh::{Cli, daemon::{self, Daemon}, Commands, DATA_FILE, async_watch, volume::VolumeInfo};

use std::fs;
use clap::Parser;

pub fn main() {
    let args = Cli::parse();

    // ······
    // daemon
    // ······

    if args.kill_daemon {
        if let Err(e) = daemon::kill() {
            eprintln!("error: {}", e);
        }
    }

    if args.daemon {
        Daemon::new().start();
    }

    if args.kill_daemon || args.daemon {
        return;
    }

    // ········
    // commands
    // ········
    
    if let Some(cmd) = args.command {
        match cmd {
            Commands::Get { battery, network, volume, monitor } => {
                if battery { get_value("battery", monitor) }
                else if network { get_value("network", monitor) }
                else if volume { get_value("volume", monitor) }
            },
            Commands::Volume { set, add, sub, mute, toggle_mute } => {
                if let Some(v) = set { VolumeInfo::new().set_volume(v); }
                else if let Some(v) = add { VolumeInfo::new().add_volume(v); }
                else if let Some(v) = sub { VolumeInfo::new().add_volume(-v); }
                else if let Some(v) = mute { VolumeInfo::new().mute(v); }
                else if toggle_mute { VolumeInfo::new().toggle_mute(); }
            },
        }
    }
}

fn get_value(name: &str, monitor: bool) {
    let path = format!("{}.{}", DATA_FILE, name);
    read(&path);

    if !monitor {
        return;
    }

    futures::executor::block_on(async {
        if let Err(e) = async_watch(path, &read).await {
            println!("error: {:?}", e)
        }
    });
}

fn read(path: &str) {
    let data = match fs::read_to_string(path) {
        Ok(data) => data,
        Err(_) => {
            eprintln!("unable to retrieve the daemon data. is it running?");
            "".to_string()
        }
    };
    println!("{}", data);
}
