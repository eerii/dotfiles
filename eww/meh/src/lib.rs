pub mod battery;
pub mod wifi;

use battery::BatteryCmd;
use wifi::WifiCmd;
use clap::{Parser, ArgGroup};

#[derive(Parser, Debug)]
#[command(author, version, about)]
#[clap(group(ArgGroup::new("cmd").required(true)))]
pub struct Args {
    #[arg(short, long)]
    #[clap(value_enum, group = "cmd")]
    pub battery: Option<BatteryCmd>,

    #[arg(short, long)]
    #[clap(value_enum, group = "cmd")]
    pub wifi: Option<WifiCmd>,
}
