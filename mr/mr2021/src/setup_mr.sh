#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install MR"

cd ${MR_DIR} 
source /opt/ros/${ROS_DISTRO}/setup.bash
catkin_make -DCMAKE_BUILD_TYPE=Debug 
echo "source ${MR_DIR}/devel/setup.bash" >> ~/.bashrc
