cd robot_ws/src

git clone https://github.com/PX4/px4_ros_com.git 
git clone https://github.com/PX4/px4_msgs.git 

cd px4_msgs
git checkout daee1217b8834cb5293f7913bd7f0850c882ffb7
cd ..

cd px4_ros_com
git checkout 7e25c34df0aab25d6e723385322c62712ea97207
cd ..

cd px4_ros_com/scripts
bash build_ros2_workspace.bash




