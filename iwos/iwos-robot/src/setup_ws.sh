#!/bin/bash

set -e

echo "Install ws"

source /opt/ros/${ROS_DISTRO}/setup.bash

# setup gamepad control in container
apt-get install -y ros-noetic-joy

# create and build workspace for general packages
mkdir -p ${PROJECT_ROOT}/ws00/src
cd ${PROJECT_ROOT}/ws00/src  && \
	git clone -b noetic https://github.com/tuw-robotics/tuw_msgs.git && \
	git clone -b devel-iwos https://github.com/tuw-robotics/tuw_teleop.git

cd ${PROJECT_ROOT}/ws00 && catkin_make
source ${PROJECT_ROOT}/ws00/devel/setup.bash
echo 'source ${PROJECT_ROOT}/ws00/devel/setup.bash' >> ~/.bashrc

# rosdep
apt-get update
rosdep install --skip-keys=tuw_nav_msgs tuw_gamepad

# create and build worksprace for IWOS specific packages
mkdir -p ${PROJECT_ROOT}/ws01/src
cd ${PROJECT_ROOT}/ws01/src && \
	git clone -b devel https://github.com/ek-robotics/tuw_dynamixel.git && \
	git clone -b devel https://github.com/ek-robotics/tuw_iwos.git && \
	git clone -b devel https://github.com/ek-robotics/tuw_trinamic.git

cd ${PROJECT_ROOT}/ws01 && catkin_make
source ${PROJECT_ROOT}/ws01/devel/setup.bash
echo 'source ${PROJECT_ROOT}/ws01/devel/setup.bash' >> ~/.bashrc

# rosdep
apt-get update
rosdep install --skip-keys=tuw_nav_msgs tuw_dynamixel_controller
rosdep install --skip-keys=tuw_nav_msgs tuw_trinamic_controller
