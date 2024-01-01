use crate::{
    battery::BatteryInfo,
    net::NetInfo,
    notify::{self, register_dbus_handler, Action},
    volume::VolumeInfo,
    Info, DATA_FILE, DIR_FILE, ERR_FILE, OUT_FILE, PID_FILE,
};

use daemonize::Daemonize;
use glob::glob;
use networkmanager::types::ActiveConnectionState;
use std::{
    error::Error,
    fs::{self, read_to_string, remove_file, File},
    sync::{mpsc, Arc, RwLock},
    thread, time,
};
use sysinfo::{Pid, ProcessExt, Signal, System, SystemExt};

pub struct Daemon {
    info: Info,
    it: usize,
    dbus_manager: Arc<RwLock<notify::Manager>>,
}

impl Default for Daemon {
    fn default() -> Self {
        Daemon {
            info: Info {
                volume: VolumeInfo::default(),
                network: NetInfo::default(),
                battery: BatteryInfo::default(),
            },
            it: 0,
            dbus_manager: Arc::new(RwLock::new(notify::Manager::new())),
        }
    }
}

impl Daemon {
    pub fn start(mut self) {
        fs::create_dir_all(DIR_FILE).expect("couldn't create the daemon directory");
        let stdout = File::create(OUT_FILE).unwrap();
        let stderr = File::create(ERR_FILE).unwrap();

        let daemon = Daemonize::new()
            .pid_file(PID_FILE)
            .stdout(stdout)
            .stderr(stderr);

        match daemon.start() {
            Ok(_) => {
                println!("the meh daemon has started");
                self.run();
            }
            Err(e) => eprintln!("{}", e),
        }
    }

    fn run(&mut self) {
        let (sender, receiver) = mpsc::channel();
        thread::spawn(move || register_dbus_handler(sender));

        // notification loop
        let dbus = self.dbus_manager.clone();
        thread::spawn(move || loop {
            if let Ok(recv) = receiver.recv() {
                match recv {
                    Action::Show(n) => {
                        println!(
                            "received notification: {}\napp: {}\n{}\n{}",
                            n.id, n.app_name, n.summary, n.body
                        );
                        dbus.write()
                            .expect("failed to write into the dbus manager")
                            .add(n);
                    }
                    Action::Close(_) => {}
                }
            }
        });

        // daemon loop
        loop {
            if self.it % 5 == 0 {
                self.info.battery.update();
            }

            if self.it % 20 == 0 {
                self.info.volume.update();
            }

            let net_delay = match self.info.network.state {
                ActiveConnectionState::Activating => 2,
                _ => 5,
            };
            if self.it % net_delay == 0 {
                self.info.network.update();
            }

            self.it += 1;
            thread::sleep(time::Duration::from_millis(100));
        }
    }
}

pub fn kill() -> Result<(), Box<dyn Error>> {
    let pid = read_to_string(PID_FILE)
        .map_err(|_| "the daemon doesn't seem to be running")?
        .trim()
        .parse::<usize>()?;
    let s = System::new_all();

    if let Some(process) = s.process(Pid::from(pid)) {
        if process.kill_with(Signal::Kill).is_none() {
            eprintln!("this platform doesn't support the kill signal");
        }
    }

    remove_file(PID_FILE)?;
    for path in glob(&format!("{}.*", DATA_FILE)).unwrap() {
        match path {
            Ok(path) => fs::remove_file(path)?,
            Err(e) => eprintln!("{}", e),
        }
    }

    println!("killed daemon with pid {}", pid);
    Ok(())
}
