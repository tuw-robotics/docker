#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install ws"

source /opt/ros/${ROS_DISTRO}/setup.bash
cd ${PRJ_DIR}/ros/ws00
catkin_make
source ${PRJ_DIR}/ros/ws00/devel/setup.bash
echo "source ${PRJ_DIR}/ros/ws00/devel/setup.bash" >> ~/.bashrc

cd ${PRJ_DIR}/ros/ws01
#catkin_make -DCMAKE_BUILD_TYPE=Debug 
#source ${PRJ_DIR}/ros/ws01/devel/setup.bash
#echo "source ${PRJ_DIR}/ros/ws01/devel/setup.bash" >> ~/.bashrc
