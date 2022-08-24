#!/bin/bash

set -e

echo "Install ws"

source /opt/ros/${ROS_DISTRO}/setup.bash

# create and build workspace for general packages
mkdir -p ${PROJECT_ROOT}/ws00/src
cd ${PROJECT_ROOT}/ws00/src  && \
	git clone git@github.com:tuw-robotics/grid_map.git  && \
	git clone git@github.com:tuw-robotics/tuw_msgs.git

cd ${PROJECT_ROOT}/ws00 && catkin_make
source ${PROJECT_ROOT}/ws00/devel/setup.bash
echo 'source ${PROJECT_ROOT}/ws00/devel/setup.bash' >> ~/.bashrc

# create and build worksprace 
mkdir -p ${PROJECT_ROOT}/ws01/src
cd ${PROJECT_ROOT}/ws01/src && \
	git git@github.com:tuw-robotics/tuw_rviz.git
	git git@github.com:tuw-robotics/tuw_agv.git
	git git@github.com:tuw-robotics/tuw_control.git
	git git@github.com:tuw-robotics/tuw_geometry.git
	git git@github.com:tuw-robotics/tuw_teleop.git
	git git@github.com:tuw-robotics/tuw_collision_alarm.git
	git git@github.com:tuw-robotics/tuw_global_planner.git

cd ${PROJECT_ROOT}/ws01 && catkin_make
source ${PROJECT_ROOT}/ws01/devel/setup.bash
echo 'source ${PROJECT_ROOT}/ws01/devel/setup.bash' >> ~/.bashrc


# create and build worksprace 
mkdir -p ${PROJECT_ROOT}/ws02/src
cd ${PROJECT_ROOT}/ws02/src && \
	git git@github.com:tuw-robotics/tuw_multi_robot.git

cd ${PROJECT_ROOT}/ws02 && catkin_make
source ${PROJECT_ROOT}/ws02/devel/setup.bash
echo 'source ${PROJECT_ROOT}/ws02/devel/setup.bash' >> ~/.bashrc


# create and build worksprace 
mkdir -p ${PROJECT_ROOT}/ws02/src
cd ${PROJECT_ROOT}/ws02/src && \
	git git@github.com:tuw-robotics/tuw_multi_robot.git

cd ${PROJECT_ROOT}/ws02 && catkin_make
source ${PROJECT_ROOT}/ws02/devel/setup.bash
echo 'source ${PROJECT_ROOT}/ws02/devel/setup.bash' >> ~/.bashrc
