#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install ROS dependencies for MR"

apt-get install -y \
    libfltk1.3-dev \
    git tmux vim wget gzip
    
mkdir -p ${MY_HOME}/ros2_ws/src
git clone https://github.com/tuw-robotics/stage_ros2.git ~/ros2_ws/src/
cd ${MY_HOME}/ros2_ws/

source /opt/ros/${ROS_DISTRO}/setup.bash
colcon build --symlink-install
