pip3 install jsonschema

cd /home/ubuntu
git clone https://github.com/PX4/PX4-Autopilot --recursive
cd PX4-Autopilot
git checkout 30150f723a69068d12de9295b5d7e1e4fdbf4677 #release/1.13
git submodule update --recursive
git submodule update --init --recursive

cd /home/ubuntu
git clone https://github.com/mavlink/mavlink.git --recursive
PYTHONPATH=/home/user/mavlink
