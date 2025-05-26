use half::f16;
use socketcan::{CANFrame, CANSocket};
use std::time::Duration;

pub struct SparkMax {
    id: u8,
    socket: CANSocket,
}

impl SparkMax {
    pub fn new(id: u8, iface: &str) -> std::io::Result<Self> {
        let socket = CANSocket::open(iface)?;
        socket.set_write_timeout(Some(Duration::from_millis(10)))?;
        Ok(SparkMax { id, socket })
    }

    fn base_id(&self, api_id: u32) -> u32 {
        api_id | (self.id as u32)
    }

    pub fn set_speed(&self, rpm: f32) -> std::io::Result<()> {
        let api_id = 0x2050480; // speed Set
        let can_id = self.base_id(api_id);
        let rpm_bytes = rpm.to_le_bytes();

        let data = [
            rpm_bytes[0],
            rpm_bytes[1],
            rpm_bytes[2],
            rpm_bytes[3],
            0x00,
            0x00,
            0x00,
            0x00, // aux, pid slot
        ];

        let frame = CANFrame::new(can_id, &data, false, false)?;
        self.socket.write_frame(&frame)?;
        Ok(())
    }

    pub fn read_velocity(&self) -> std::io::Result<f32> {
        let frame = self.socket.read_frame()?;
        let id = frame.id();

        let expected_id = self.base_id(0x2051840);
        if id != expected_id {
            return Err(std::io::Error::new(
                std::io::ErrorKind::Other,
                "unexpected frame",
            ));
        }

        let data = frame.data();

        let vel_half = f16::from_bits(u16::from_le_bytes([data[0], data[1]]));
        Ok(f32::from(vel_half))
    }
}
