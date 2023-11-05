use std::io;
use serde::{Deserialize, Serialize};
use battery::{Manager, Battery, State, units::ratio};

static ICONS: [&str; 11] = ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"];
static ICONS_CHARGING: [&str; 11] = ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"];

#[derive(clap::ValueEnum, Debug, Clone)]
pub enum BatteryCmd {
    Percent,
    State,
    Icon,
}

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
}

impl Default for BatteryInfo {
    fn default() -> Self {
        Self {
            percent: 0,
            icon: "󱉞".to_string(),
            state: State::Unknown,
        }
    }
}

pub fn get_battery() -> Result<BatteryInfo, battery::Error> {
    let manager = Manager::new()?;

    let bat = match manager.batteries()?.next() {
        Some(Ok(bat)) => bat,
        Some(Err(e)) => {
            eprintln!("unable to access battery information");
            return Err(e);
        },
        None => {
            eprintln!("unable to find any batteries");
            return Err(io::Error::from(io::ErrorKind::NotFound).into());
        },
    };

    Ok(BatteryInfo {
        percent: percent(&bat) as i32,
        icon: icon(&bat).to_string(),
        state: bat.state()
    })
}

fn percent(bat: &Battery) -> f32 {
    (bat.energy() / bat.energy_full())
        .get::<ratio::percent>()
        .clamp(0.0, 100.0)
}

fn icon(bat: &Battery) -> &'static str {
    let p : usize = percent(bat) as usize / 10;

    match bat.state() {
        State::Full => "󱈑",
        State::Empty => "󱟥",
        State::Charging => ICONS_CHARGING[p],
        State::Discharging => ICONS[p],
        State::Unknown => "󱟩",
        _ => unreachable!(),
    }
}
