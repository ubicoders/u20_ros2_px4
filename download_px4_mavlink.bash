cd /home/ubuntu
git clone https://github.com/PX4/PX4-Autopilot --recursive
cd PX4-Autopilot
# use release/1.13-based image for reproducibility !
git checkout 30150f723a69068d12de9295b5d7e1e4fdbf4677 
git submodule update --recursive
git submodule update --init --recursive

cd /home/ubuntu
git clone https://github.com/mavlink/mavlink.git --recursive


