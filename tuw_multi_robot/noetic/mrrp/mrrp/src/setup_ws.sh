#!/bin/bash

set -e

echo "Install ws"

source /opt/ros/${ROS_DISTRO}/setup.bash

# create and build workspace for general packages
mkdir -p ${PROJECT_ROOT}/ws00/src
cd ${PROJECT_ROOT}/ws00/src  && \
	git clone https://github.com/tuw-robotics/tuw_geometry.git  && \
	git clone https://github.com/tuw-robotics/tuw_msgs.git 

cd ${PROJECT_ROOT}/ws00 && catkin_make
source ${PROJECT_ROOT}/ws00/devel/setup.bash
echo 'source ${PROJECT_ROOT}/ws00/devel/setup.bash' >> ~/.bashrc

# create and build worksprace for IWOS specific packages
mkdir -p ${PROJECT_ROOT}/ws01/src
cd ${PROJECT_ROOT}/ws01/src && \
	git clone https://github.com/tuw-robotics/tuw_multi_robot.git

cd ${PROJECT_ROOT}/ws01 && catkin_make
source ${PROJECT_ROOT}/ws01/devel/setup.bash
echo 'source ${PROJECT_ROOT}/ws01/devel/setup.bash' >> ~/.bashrc

