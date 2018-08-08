git clone https://github.com/uptech/alt ~/.repos/alt
cd ~/.repos/alt
cargo build --release
cd -
sudo cp -v ~/.repos/alt/target/release/alt /usr/local/bin
sudo cp -v ~/.repos/a
