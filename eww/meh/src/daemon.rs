use crate::{Info, battery::BatteryInfo, notify::{self, register_dbus_handler, Action}, volume::VolumeInfo, net::NetInfo, DIR_FILE, OUT_FILE, ERR_FILE, PID_FILE, DATA_FILE};

use std::{fs::{File, read_to_string, remove_file, self}, thread, time, error::Error, sync::{mpsc, Arc, RwLock}};
use networkmanager::types::ActiveConnectionState;
use sysinfo::{Pid, ProcessExt, Signal, System, SystemExt};
use daemonize::Daemonize;
use glob::glob;

pub struct Daemon {
    info: Info,
    it: usize,
    dbus_manager: Arc<RwLock<notify::Manager>>,
}

impl Daemon {
    pub fn new() -> Self {
        Daemon {
            info: Info {
                volume: VolumeInfo::new(),
                network: NetInfo::new(),
                battery: BatteryInfo::new(),
            },
            it: 0,
            dbus_manager: Arc::new(RwLock::new(notify::Manager::new())),
        }
    }

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
            },
            Err(e) => eprintln!("{}", e),
        } 
    } 

    fn run(&mut self) {
        let (sender, receiver) = mpsc::channel();
        thread::spawn(move || register_dbus_handler(sender));
  
        // notification loop
        let dbus = self.dbus_manager.clone();
        thread::spawn(move || {
            loop {
                if let Ok(recv) = receiver.recv() {
                    match recv {
                        Action::Show(n) => {
                            println!("received notification: {}\napp: {}\n{}\n{}",
                                n.id, n.app_name, n.summary, n.body);
                            dbus.write().expect("failed to write into the dbus manager").add(n);
                        },
                        Action::Close(_) => {},
                    }
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
        .or_else(|_| Err("the daemon doesn't seem to be running"))?
        .trim().parse::<usize>()?;
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
            Err(e) => eprintln!("{}", e)
        }
    }

    println!("killed daemon with pid {}", pid);
    Ok(())
}
