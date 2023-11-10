use std::{process::Command, str::from_utf8};

use serde::{Deserialize, Serialize};
use serde_json::Value;

use crate::{write_data, HasPrev};

const ICON_UNKNOWN: &str = "󰖁";
const ICON_MUTE: &str = "󰕿";
const ICON_MIN: &str = "󰖀";
const ICON_MAX: &str = "󰕾";

const WPCTL_CMD: &str = "wpctl";
const WPCTL_SINK: &str = "@DEFAULT_AUDIO_SINK@";

#[derive(Serialize, Deserialize, Debug, Default)]
pub enum State {
    #[default]
    Unknown,
    Mute,
    Regular,
}

pub enum Wpctl {
    GetVolume,
    SetVolume(u32),
    AddVolume(i32),
    Mute,
    Unmute,
    ToggleMute,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct VolumeInfo {
    pub volume: u32,
    pub icon: String,
    pub state: State,
    #[serde(skip_serializing, skip_deserializing)]
    prev: Option<Value>,
}

impl HasPrev for VolumeInfo {
    fn prev(&mut self, next: Value) -> Value {
        let curr = self.prev.clone().unwrap_or_default();
        self.prev = Some(next);
        curr
    }
}

impl VolumeInfo {
    pub fn new() -> Self {
        VolumeInfo {
            volume: 0,
            icon: ICON_UNKNOWN.to_string(),
            state: State::default(),
            prev: None,
        }
    }

    pub fn update(&mut self) {
        self.run_wpctl(Wpctl::GetVolume);
        write_data(self, "volume");
    }

    pub fn set_volume(&mut self, vol: u32) {
        self.run_wpctl(Wpctl::Unmute);
        self.run_wpctl(Wpctl::SetVolume(vol));
        self.update();
    }

    pub fn add_volume(&mut self, vol: i32) {
        self.run_wpctl(Wpctl::Unmute);
        self.run_wpctl(Wpctl::AddVolume(vol));
        self.update();
    }

    pub fn mute(&mut self, m: bool) {
        self.run_wpctl(if m {Wpctl::Mute} else {Wpctl::Unmute});
        self.update();
    }

    pub fn toggle_mute(&mut self) {
        self.run_wpctl(Wpctl::ToggleMute);
        self.update();
    }

    fn run_wpctl(&mut self, action: Wpctl) {
        let out = Command::new(WPCTL_CMD)
            .arg(match action {
                Wpctl::GetVolume => "get-volume",
                Wpctl::SetVolume(_) | Wpctl::AddVolume(_) => "set-volume",
                Wpctl::Mute | Wpctl::Unmute | Wpctl::ToggleMute => "set-mute",
            })
            .arg(WPCTL_SINK)
            .arg(match action {
                Wpctl::SetVolume(vol) => format!("{}%", vol),
                Wpctl::AddVolume(vol) => format!("{}%{}", vol.abs(), if vol > 0 {"+"} else {"-"}),
                Wpctl::Mute => "1".to_string(),
                Wpctl::Unmute => "0".to_string(),
                Wpctl::ToggleMute => "toggle".to_string(),
                _ => "".to_string(),
            })
            .arg(match action {
                Wpctl::SetVolume(_) | Wpctl::AddVolume(_) => "-l",
                _ => "",
            })
            .arg(match action {
                Wpctl::SetVolume(_) | Wpctl::AddVolume(_) => "1.0",
                _ => "",
            })
            .output()
            .unwrap();

        match action {
            Wpctl::GetVolume => {
                let res = from_utf8(&out.stdout[..]).unwrap().split(" ");
                
                let vol = res.clone().nth(1)
                    .unwrap_or("0.0").trim()
                    .parse::<f32>().unwrap();
                self.volume = (vol * 100.0).round() as u32;

                self.state = if self.volume == 0 || res.count() > 2 {
                    State::Mute
                } else {
                    State::Regular
                };
            },
            Wpctl::Mute => self.state = State::Mute,
            Wpctl::Unmute => self.state = State::Regular,
            Wpctl::ToggleMute => self.state = match self.state {
                State::Mute | State::Unknown => State::Regular,
                State::Regular => State::Mute,
            },
            _ => ()
        }

        self.icon = match self.state { 
            State::Unknown => ICON_UNKNOWN,
            State::Mute => ICON_MUTE,
            State::Regular => if self.volume > 50 { ICON_MAX } else { ICON_MIN },
        }.to_string();
    }
}
