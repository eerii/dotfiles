use serde::{Deserialize, Serialize};

#[derive(clap::ValueEnum, Debug, Clone)]
pub enum NetCmd {
    Coverage,
    State,
    Icon,
    Name,
    Ip,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct NetInfo {
    pub icon: String,
}

impl Default for NetInfo {
    fn default() -> Self {
        Self {
            icon: "󰤮".to_string(),
        }
    }
}
