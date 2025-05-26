mod sparkmax;

use sparkmax::SparkMax;
use std::thread::sleep;
use std::time::Duration;

fn main() -> std::io::Result<()> {
    let motor = SparkMax::new(3, "can0")?;

    println!("set speed 2000.0");
    motor.set_speed(2000.0)?;

    loop {
        let vel = motor.read_velocity()?;
        println!("velocity: {:.2} RPM", vel);
        sleep(Duration::from_millis(50));
    }
}
