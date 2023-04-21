use std::thread::sleep;
use std::time::Duration;

use log::info;

fn main() {
    pretty_env_logger::init_timed();
    loop {
        info!("Hello, world!");
        sleep(Duration::from_secs(5));
    }
}
