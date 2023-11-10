use crate::{HasPrev, write_data};

use serde::{Deserialize, Serialize};
use serde_json::Value;

use networkmanager::{NetworkManager, devices::{Any, Device, Wireless}, types::ActiveConnectionState};

const ICONS: [&str; 5] = ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"];
const ICON_UNKNOWN: &str = "󰤭";
const ICON_DEACTIVATED: &str = "󰤮";

#[derive(Serialize, Deserialize)]
#[serde(remote = "ActiveConnectionState")]
pub enum StateDef {
    Unknown,
    Activating,
    Activated,
    Deactivating,
    Deactivated,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct NetInfo {
    pub icon: String,
    pub name: String,
    pub uuid: String,
    pub strength: u8,
    #[serde(with = "StateDef")]
    pub state: ActiveConnectionState,
    #[serde(skip_serializing, skip_deserializing)]
    prev: Option<Value>,
}

impl HasPrev for NetInfo {
    fn prev(&mut self, next: Value) -> Value {
        let curr = self.prev.clone().unwrap_or_default();
        self.prev = Some(next);
        curr
    }
}

impl NetInfo {
    pub fn new() -> Self {
        NetInfo {
            icon: ICON_UNKNOWN.to_string(),
            name: "".to_string(),
            uuid: "".to_string(),
            strength: 0,
            state: ActiveConnectionState::Unknown,
            prev: None, 
        }
    }

    pub fn update(&mut self) {
        let dbus = dbus::blocking::Connection::new_system().expect("failed to connect to dbus");
        let nm = NetworkManager::new(&dbus);
        
        self.state = ActiveConnectionState::Unknown;

        if let Ok(dev) = nm.get_device_by_ip_iface("wlp3s0") {
            match dev {
                Device::WiFi(dev) => {
                    if let Ok(ap) = dev.active_access_point() {
                        self.strength = ap.strength().unwrap_or(0);
                    }
                    if let Ok(conn) = dev.active_connection() {
                        self.state = conn.state().unwrap_or(ActiveConnectionState::Unknown);
                        self.name = conn.id().unwrap_or("".to_string());
                        self.uuid = conn.uuid().unwrap_or("".to_string()); 
                    } 
                },
                _ => ()
            }
        }

        self.icon = match self.state {
            ActiveConnectionState::Unknown => ICON_UNKNOWN,
            ActiveConnectionState::Activating => {
                let next = ICONS.iter().position(|&x| x == self.icon).unwrap_or(0) + 1;
                ICONS[next % ICONS.len()]
            }
            ActiveConnectionState::Activated => {
                ICONS[self.strength as usize / 20]
            },
            ActiveConnectionState::Deactivating | ActiveConnectionState::Deactivated => ICON_DEACTIVATED,
        }.to_string();

        write_data(self, "network");
    }
}
