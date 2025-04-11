use rusb::{DeviceHandle, GlobalContext, UsbContext};
use std::time::Duration;

const VID: u16 = 0x0483;
const PID: u16 = 0xa30e;

const ENDPOINT_OUT: u8 = 0x02;
const ENDPOINT_IN: u8 = 0x81;

fn find_device() -> rusb::Result<DeviceHandle<GlobalContext>> {
    for device in rusb::devices()?.iter() {
        let desc = device.device_descriptor()?;
        if desc.vendor_id() == VID && desc.product_id() == PID {
            let mut handle = device.open()?;
            handle.claim_interface(0)?;
            return Ok(handle);
        }
    }
    Err(rusb::Error::NoDevice)
}

fn build_command_packet() -> [u8; 12] {
    // Construct a 12-byte CAN-like packet
    // ExtID = 0x00150200 for API Class 0x08, Index 0x00, Device ID 0x00
    let ext_id: u32 = (0b000 << 29) | // Standard Command Type
        (0x02 << 24) |  // Device Type
        (0x15 << 16) |  // Manufacturer
        (0x08 << 10) |  // API Class
        (0x00 << 6)  |  // API Index
        (0x00); // Device ID

    let mut packet = [0u8; 12];
    packet[..4].copy_from_slice(&ext_id.to_le_bytes());

    // Data bytes (example: set motor speed or something)
    packet[4..12].copy_from_slice(&[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]);

    packet
}

fn main() -> rusb::Result<()> {
    let handle = find_device()?;

    let packet = build_command_packet();

    println!("Sending packet: {:02x?}", packet);

    let bytes_written = handle.write_bulk(ENDPOINT_OUT, &packet, Duration::from_millis(100))?;
    println!("Wrote {} bytes to SPARK MAX", bytes_written);

    let mut response = [0u8; 64];
    match handle.read_bulk(ENDPOINT_IN, &mut response, Duration::from_millis(500)) {
        Ok(n) => println!("Response: {:02x?}", &response[..n]),
        Err(e) => println!("No response or error: {}", e),
    }

    Ok(())
}
