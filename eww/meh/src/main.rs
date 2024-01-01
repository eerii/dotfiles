use meh::{
    async_watch,
    daemon::{self, Daemon},
    volume::VolumeInfo,
    Cli, Commands, DATA_FILE,
};

use clap::Parser;
use std::fs;

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
        Daemon::default().start();
    }

    if args.kill_daemon || args.daemon {
        return;
    }

    // ········
    // commands
    // ········

    if let Some(cmd) = args.command {
        match cmd {
            Commands::Get {
                battery,
                network,
                volume,
                monitor,
            } => {
                if battery {
                    get_value("battery", monitor)
                } else if network {
                    get_value("network", monitor)
                } else if volume {
                    get_value("volume", monitor)
                }
            }
            Commands::Volume {
                set,
                add,
                sub,
                mute,
                toggle_mute,
            } => {
                if let Some(v) = set {
                    VolumeInfo::default().set_volume(v);
                } else if let Some(v) = add {
                    VolumeInfo::default().add_volume(v);
                } else if let Some(v) = sub {
                    VolumeInfo::default().add_volume(-v);
                } else if let Some(v) = mute {
                    VolumeInfo::default().mute(v);
                } else if toggle_mute {
                    VolumeInfo::default().toggle_mute();
                }
            }
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
