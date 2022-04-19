#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install MR"

cd ${MR_DIR} 
source /opt/ros/${ROS_DISTRO}/setup.bash
colcon build  
