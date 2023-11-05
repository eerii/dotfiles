use crate::{Info, battery::get_battery};

use std::{fs::{File, read_to_string, remove_file, self}, thread, time, error::Error};
use sysinfo::{Pid, ProcessExt, Signal, System, SystemExt};
use daemonize::Daemonize;

static OUT: &str = "/tmp/meh.out";
static ERR: &str = "/tmp/meh.err";
static PID: &str = "/tmp/meh.pid";
pub static DATA_FILE: &str = "/tmp/meh.data";

#[derive(Default)]
pub struct Daemon {
    info: Info,
}

impl Daemon {
    pub fn start(self) {
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

    fn run(mut self) {
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

            let serialized = toml::to_string(&self.info).unwrap();
            fs::write(DATA_FILE, serialized).expect("couldn't write to the data file");

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
