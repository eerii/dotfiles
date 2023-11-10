use serde::{Deserialize, Serialize};
use battery::{Manager, Battery, State, units::ratio};
use serde_json::Value;

use crate::{HasPrev, write_data};

const ICONS: [&str; 11] = ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"];
const ICONS_CHARGING: [&str; 11] = ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"];
const ICON_UNKNOWN: &str = "󱟩";
const ICON_FULL: &str = "󱈑";
const ICON_EMPTY: &str = "󱟥";

#[derive(Serialize, Deserialize)]
#[serde(remote = "State")]
pub enum StateDef {
    Unknown,
    Charging,
    Discharging,
    Empty,
    Full,
    __Nonexhaustive,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct BatteryInfo {
    pub percent: i32,
    pub icon: String,
    #[serde(with = "StateDef")]
    pub state: State,
    #[serde(skip_serializing, skip_deserializing)]
    manager: Option<Manager>,
    #[serde(skip_serializing, skip_deserializing)]
    prev: Option<Value>,
}

impl HasPrev for BatteryInfo {
    fn prev(&mut self, next: Value) -> Value {
        let curr = self.prev.clone().unwrap_or_default();
        self.prev = Some(next);
        curr
    }
}

impl BatteryInfo {
    pub fn new() -> Self {
        let manager = Manager::new().expect("error getting battery manager");

        BatteryInfo {
            percent: 0,
            icon: ICON_UNKNOWN.to_string(),
            state: State::Unknown,
            manager: Some(manager),
            prev: None
        }
    }

    pub fn update(&mut self) {
        write_data(self, "battery");

        match self.manager.as_ref().expect("battery info was not initialized")
                .batteries().expect("there are no batteries").next() {
            Some(Ok(bat)) => {
                self.percent = percent(&bat) as i32;
                self.icon = icon(&bat).to_string();
                self.state = bat.state();
                write_data(self, "battery");
            },
            Some(Err(e)) => {
                eprintln!("unable to access battery information: {}", e);
            },
            None => {
                eprintln!("unable to find any batteries");
            },
        }
    }
}

fn percent(bat: &Battery) -> f32 {
    (bat.energy() / bat.energy_full())
        .get::<ratio::percent>()
        .clamp(0.0, 100.0)
}

fn icon(bat: &Battery) -> &'static str {
    let p : usize = percent(bat) as usize / 10;

    match bat.state() {
        State::Full => ICON_FULL,
        State::Empty => ICON_EMPTY,
        State::Charging => ICONS_CHARGING[p],
        State::Discharging => ICONS[p],
        State::Unknown => ICON_UNKNOWN,
        _ => unreachable!(),
    }
}
