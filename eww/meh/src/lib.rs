pub mod daemon;
pub mod battery;
pub mod net;
pub mod volume;
pub mod notify;

use battery::{BatteryCmd, BatteryInfo};
use net::{NetCmd, NetInfo};
use volume::{VolumeCmd, VolumeInfo};

use serde::{Deserialize, Serialize};
use clap::{Parser, ArgGroup};

#[derive(Parser, Debug)]
#[command(author, version, about)]
#[clap(group(ArgGroup::new("cmd").required(true)))]
pub struct Args {
    #[arg(short, long, action)]
    #[clap(group = "cmd")]
    pub daemon: bool,

    #[arg(short, long, action)]
    #[clap(group = "cmd")]
    pub kill_daemon: bool,

    #[arg(short, long)]
    #[clap(value_enum, group = "cmd")]
    pub battery: Option<BatteryCmd>,

    #[arg(short, long)]
    #[clap(value_enum, group = "cmd")]
    pub network: Option<NetCmd>,

    #[arg(short, long)]
    #[clap(value_enum, group = "cmd")]
    pub volume: Option<VolumeCmd>,
}

#[derive(Serialize, Deserialize, Debug, Default)]
pub struct Info {
    pub battery: Option<BatteryInfo>,
    pub network: Option<NetInfo>,
    pub volume: Option<VolumeInfo>,
}
