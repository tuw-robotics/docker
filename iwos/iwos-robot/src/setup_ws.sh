#!/bin/bash

set -e

echo "Install workspace"

source /opt/ros/${ROS_DISTRO}/setup.bash

apt-get update && apt-get install -y libncurses5-dev

# create and build workspace for general packages
mkdir -p ${PROJECT_ROOT}/ws00/src
cd ${PROJECT_ROOT}/ws00/src
git clone -b noetic https://github.com/tuw-robotics/tuw_msgs.git
git clone -b devel-iwos https://github.com/tuw-robotics/tuw_teleop.git

cd ${PROJECT_ROOT}/ws00 && catkin_make
source ${PROJECT_ROOT}/ws00/devel/setup.bash
echo "source ${PROJECT_ROOT}/ws00/devel/setup.bash" >> ~/.bashrc

rosdep install -y --skip-keys=tuw_nav_msgs tuw_gamepad

# create and build worksprace for IWOS specific packages
mkdir -p ${PROJECT_ROOT}/ws01/src
cd ${PROJECT_ROOT}/ws01/src
git clone -b devel https://github.com/ek-robotics/tuw_dynamixel.git
git clone -b devel https://github.com/ek-robotics/tuw_iwos.git
git clone -b devel https://github.com/ek-robotics/tuw_trinamic.git

cd ${PROJECT_ROOT}/ws01 && catkin_make
source ${PROJECT_ROOT}/ws01/devel/setup.bash
echo "source ${PROJECT_ROOT}/ws01/devel/setup.bash" >> ~/.bashrc

# rosdep
rosdep install -y --skip-keys=tuw_nav_msgs tuw_dynamixel_controller
rosdep install -y --skip-keys=tuw_nav_msgs tuw_trinamic_controller
