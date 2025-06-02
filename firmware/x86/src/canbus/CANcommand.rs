use std::time::{Duration, Instant};

// high level command for a joint: turn to this angle
pub struct JointCommand {
    pub joint_id: u8,
    pub joint_angle: f64,
    pub timestamp: Instant,
}

/// you can unwrap this
impl JointCommand {
    pub fn joint_command_from(
        joint_id: u8,
        joint_angle: f64,
    ) -> Result<Self, Box<dyn std::error::Error>> {
        let timestamp = std::time::Instant::now();
        Ok(Self {
            joint_id,
            joint_angle,
            timestamp,
        })
    }
}
