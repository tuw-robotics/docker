#!/bin/bash

set -e

echo "Install ws"

source /opt/ros/${ROS_DISTRO}/setup.bash

# create and build workspace for general packages
mkdir -p ${PROJECT_ROOT}/ws00/src
cd ${PROJECT_ROOT}/ws00/src  && \
	git clone https://github.com/tuw-robotics/tuw_msgs.git && \
	git clone -b devel-iwos https://github.com/tuw-robotics/tuw_teleop.git

source /opt/ros/${ROS_DISTRO}/setup.bash && cd ${PROJECT_ROOT}/ws00 && catkin_make
source ${PROJECT_ROOT}/ws00/devel/setup.bash
echo 'source ${PROJECT_ROOT}/ws00/devel/setup.bash' >> ~/.bashrc

# create and build worksprace for IWOS specific packages
mkdir -p ${PROJECT_ROOT}/ws01/src
cd ${PROJECT_ROOT}/ws01/src && \
	git clone -b devel https://github.com/ek-robotics/tuw_dynamixel.git && \
	git clone -b devel https://github.com/ek-robotics/tuw_iwos.git && \
	git clone -b devel https://github.com/ek-robotics/tuw_trinamic.git

source /opt/ros/${ROS_DISTRO}/setup.bash && cd ${PROJECT_ROOT}/ws01 && catkin_make
source ${PROJECT_ROOT}/ws01/devel/setup.bash
echo 'source ${PROJECT_ROOT}/ws01/devel/setup.bash' >> ~/.bashrc

# rosdep
rosdep install --skip-keys=tuw_nav_msgs tuw_dynamixel_iwos_steering_controller
rosdep install --skip-keys=tuw_nav_msgs tuw_trinamic_iwos_revolute_controller
