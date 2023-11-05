use meh::{Args, battery::BatteryCmd, daemon::{self, Daemon, DATA_FILE}, Info};

use std::fs;
use clap::Parser;

pub fn main() {
    let args = Args::parse();

    // ······
    // daemon
    // ······

    if args.daemon {
        Daemon::new().start();
        return;
    }

    if args.kill_daemon {
        if let Err(e) = daemon::kill() {
            eprintln!("error: {}", e);
        }
        return;
    }

    // ········
    // commands
    // ········
    
    let info = match fs::read(DATA_FILE) {
        Ok(data) => serde_bare::from_slice(&data).unwrap(),
        Err(_) => {
            eprintln!("unable to retrieve the daemon data. is it running?");
            Info::default()
        }
    };

    // battery
    if let Some(cmd) = args.battery {
        let bat = info.battery.unwrap_or_default();
        match cmd {
            BatteryCmd::Percent => println!("{}", bat.percent),
            BatteryCmd::State => println!("{}", bat.state),
            BatteryCmd::Icon => println!("{}", bat.icon),
        };
        return;
    }

    // network
    if let Some(cmd) = args.network {
        let net = info.network.unwrap_or_default();
        match cmd {
            meh::net::NetCmd::Coverage => todo!(),
            meh::net::NetCmd::State => todo!(),
            meh::net::NetCmd::Icon => println!("{}", net.icon),
            meh::net::NetCmd::Name => todo!(),
            meh::net::NetCmd::Ip => todo!(),
        };
    }

    // volume
    if let Some(cmd) = args.volume {
        let vol = info.volume.unwrap_or_default();
        match cmd {
            meh::volume::VolumeCmd::Loudness => println!("{}", vol.loudness),
            meh::volume::VolumeCmd::Icon => println!("{}", vol.icon),
        };
    }
}
