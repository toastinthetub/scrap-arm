use socketcan::{CanFrame, CanId, CanSocket, EmbeddedFrame, ExtendedId, Socket};
use std::sync::{Arc, Mutex};
use std::thread;
use std::time::Duration;

// Base extended ID for SparkMax “Speed Set” (device ID = 0)
const SPEED_SET_BASE: u32 = 0x2050480;

/// Represents a SparkMax on the CAN bus with simple set/get API.
pub struct SparkMax {
    tx: CanSocket,
    velocity: Arc<Mutex<f32>>,
}

impl SparkMax {
    /// Create a new SparkMax interface on `interface` (e.g. "can0"), with given `device_id`.
    pub fn new(interface: &str, device_id: u8) -> std::io::Result<Self> {
        // Open CAN socket for send and receive
        let tx = CanSocket::open(interface)?;
        let mut rx = CanSocket::open(interface)?;
        let velocity = Arc::new(Mutex::new(0.0_f32));
        let velocity_thread = Arc::clone(&velocity);

        // Compute the full CAN IDs including device ID
        let status1_base: u32 = 0x2051840; // base for Periodic Status 1
        let status1_id =
            CanId::Extended(ExtendedId::new(status1_base | (device_id as u32)).unwrap());

        // Spawn a thread to read CAN frames and update velocity
        thread::spawn(move || {
            loop {
                match rx.read_frame() {
                    Ok(frame) => {
                        // If the frame matches the SparkMax's status-1 ID, parse velocity
                        if frame.id() == status1_id.into() {
                            let data = frame.data();
                            if data.len() >= 4 {
                                // Bytes 0-3: motor velocity (float, RPM, little-endian):contentReference[oaicite:3]{index=3}
                                let vel = f32::from_le_bytes([data[0], data[1], data[2], data[3]]);
                                *velocity_thread.lock().unwrap() = vel;
                            }
                        }
                        println!("but we did read...")
                    }
                    Err(e) => {
                        eprintln!("CAN read error: {}", e);
                        break;
                    }
                }
            }
        });

        Ok(SparkMax { tx, velocity })
    }

    /// send closed-loop speed command in rpm to the motor.
    pub fn set_speed(&self, speed_rpm: f32, device_id: u8) -> std::io::Result<()> {
        // make the payload 32-bit float (little-endian) then zeros
        let mut data = [0u8; 8];
        data[0..4].copy_from_slice(&speed_rpm.to_le_bytes());

        // make extended CAN ID with device ID
        let can_id_val = SPEED_SET_BASE | (device_id as u32);
        let id = CanId::Extended(ExtendedId::new(can_id_val).unwrap());

        // create and send CAN data frame (8 bytes)
        let frame = CanFrame::new(id, &data).unwrap();
        self.tx.write_frame(&frame)?;
        Ok(())
    }

    /// the latest velocity (RPM) from periodic status frames.
    pub fn get_velocity(&self) -> f32 {
        *self.velocity.lock().unwrap()
    }
}

fn main() -> std::io::Result<()> {
    let interface = "can0"; // e.g. use a CANable on can0
    let device_id = 1u8; // SparkMax CAN ID

    // Initialize SparkMax interface
    let spark = SparkMax::new(interface, device_id)?;

    // Example: set speed to 1500 RPM
    spark.set_speed(1500.0, device_id)?;
    println!("Sent speed command: 1500 RPM");

    // Wait a moment to receive status frames
    thread::sleep(Duration::from_millis(100));

    // Read and print velocity from SparkMax (RPM)
    let vel = spark.get_velocity();
    println!("Current velocity (RPM): {:.2}", vel);

    Ok(())
}
