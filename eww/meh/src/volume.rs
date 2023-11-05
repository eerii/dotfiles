use serde::{Deserialize, Serialize};

#[derive(clap::ValueEnum, Debug, Clone)]
pub enum VolumeCmd {
    Loudness,
    Icon,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct VolumeInfo {
    pub loudness: i32,
    pub icon: String,
}

impl Default for VolumeInfo {
    fn default() -> Self {
        Self {
            loudness: 0,
            icon: "󰝟".to_string(),
        }
    }
}
