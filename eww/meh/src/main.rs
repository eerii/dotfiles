use clap::Parser;
use meh::{Args, battery::{self, BatteryCmd}, wifi::{self, WifiCmd}};

pub fn main() {
    let args = Args::parse();

    if let Some(b) = args.battery {
        let res = match b {
            BatteryCmd::Percent => battery::percent().unwrap_or(-1.0).to_string(),
            BatteryCmd::State => battery::state().unwrap_or(::battery::State::Unknown).to_string(),
            BatteryCmd::Icon => battery::icon().unwrap_or("").to_string(),
            BatteryCmd::All => battery::all().unwrap_or("error".to_string()),
        };
        println!("{}", res);
    }

    if let Some(w) = args.wifi {
        let res = match w {
            WifiCmd::Coverage => todo!(),
            WifiCmd::State => todo!(),
            WifiCmd::Icon => todo!(),
            WifiCmd::Name => todo!(),
            WifiCmd::Ip => todo!(),
            WifiCmd::All => { wifi::all(); todo!() },
        };
    }
}
