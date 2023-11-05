use crate::{Info, battery::get_battery, notify::{Manager, register_dbus_handler, Action}};

use std::{fs::{File, read_to_string, remove_file, self}, thread, time, error::Error, sync::mpsc};
use sysinfo::{Pid, ProcessExt, Signal, System, SystemExt};
use daemonize::Daemonize;

const OUT: &str = "/tmp/meh.out";
const ERR: &str = "/tmp/meh.err";
const PID: &str = "/tmp/meh.pid";
pub const DATA_FILE: &str = "/tmp/meh.data";

pub struct Daemon {
    info: Info,
    dbus_manager: Manager,
}

impl Daemon {
    pub fn new() -> Self {
        Daemon {
            info: Info::default(),
            dbus_manager: Manager::init(),
        }
    }

    pub fn start(mut self) {
        let stdout = File::create(OUT).unwrap();
        let stderr = File::create(ERR).unwrap();

        let daemon = Daemonize::new()
            .pid_file(PID)
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
        
        loop {
            let battery = match get_battery() {
                Ok(bat) => Some(bat),
                Err(e) => {
                    eprintln!("{}", e);
                    None
                },
            };

            self.info = Info {
                battery,
                network: None,
                volume: None,
            };
            let serialized = serde_bare::to_vec(&self.info).unwrap();
            fs::write(DATA_FILE, serialized).expect("couldn't write to the data file");

            if let Ok(recv) = receiver.recv() {
                match recv {
                    Action::Show(n) => {
                        println!("received notification: {}\napp: {}\n{}\n{}",
                        n.id,
                        n.app_name,
                        n.summary,
                        n.body);
                        self.dbus_manager.add(n);
                    },
                    Action::Close(_) => todo!(),
                }
            }

            thread::sleep(time::Duration::from_millis(1000));
        }
    }
}

pub fn kill() -> Result<(), Box<dyn Error>> {
    let pid = read_to_string(PID)
        .or_else(|_| Err("the daemon doesn't seem to be running"))?
        .trim().parse::<usize>()?;
    let s = System::new_all();

    if let Some(process) = s.process(Pid::from(pid)) {
        if process.kill_with(Signal::Kill).is_none() {
            eprintln!("this platform doesn't support the kill signal");
        }
    }

    remove_file(PID)?;
    remove_file(DATA_FILE)?;
    println!("killed daemon with pid {}", pid);
    Ok(())
}
