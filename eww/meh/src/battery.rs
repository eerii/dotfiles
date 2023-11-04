use std::io;
use battery::{Manager, Battery, State, units::ratio};

static ICONS: [&str; 11] = ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"];
static ICONS_CHARGING: [&str; 11] = ["󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"];

#[derive(clap::ValueEnum, Debug, Clone)]
pub enum BatteryCmd {
    Percent,
    State,
    Icon,
    All
}

fn get_battery() -> Result<Battery, battery::Error> {
    let manager = Manager::new()?;

    match manager.batteries()?.next() {
        Some(Ok(battery)) => Ok(battery),
        Some(Err(e)) => {
            eprintln!("unable to access battery information");
            return Err(e);
        }
        None => {
            eprintln!("unable to find any batteries");
            return Err(io::Error::from(io::ErrorKind::NotFound).into());
        }
    }
}

fn _percent(bat: &Battery) -> f32 {
    (bat.energy() / bat.energy_full())
        .get::<ratio::percent>()
        .round()
        .clamp(0.0, 100.0)
}

fn _icon(bat: &Battery) -> &'static str {
    let p : usize = _percent(bat) as usize / 10;

    match bat.state() {
        State::Full => "󱈑",
        State::Empty => "󱟥",
        State::Charging => ICONS_CHARGING[p],
        State::Discharging => ICONS[p],
        State::Unknown => "󱟩",
        _ => unreachable!(),
    }
}

pub fn percent() -> Result<f32, battery::Error> {
    let bat = get_battery()?;
    Ok(_percent(&bat))
}

pub fn state() -> Result<State, battery::Error> {
    Ok(get_battery()?.state())
}

pub fn icon() -> Result<&'static str, battery::Error> {
    let bat = get_battery()?;
    Ok(_icon(&bat))
}

pub fn all() -> Result<String, battery::Error> {
    let bat = get_battery()?;
    Ok(format!("icon: {} - percent: {} - state: {}",
        _icon(&bat), _percent(&bat), bat.state()))
}
