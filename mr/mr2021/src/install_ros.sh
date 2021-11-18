#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install ROS dependencies for MR"

apt-get install -y \
    ros-${ROS_DISTRO}-amcl \
    ros-${ROS_DISTRO}-ros-base \
    ros-${ROS_DISTRO}-gmapping \
    ros-${ROS_DISTRO}-tf \
    ros-${ROS_DISTRO}-teleop-twist-keyboard \
    ros-${ROS_DISTRO}-marker-msgs \
    ros-${ROS_DISTRO}-map-server \
    ros-${ROS_DISTRO}-move-base  \
    ros-${ROS_DISTRO}-navigation \
    ros-${ROS_DISTRO}-rviz  \
    ros-${ROS_DISTRO}-rqt-reconfigure \
	ros-${ROS_DISTRO}-rqt-common-plugins \
    ros-${ROS_DISTRO}-slam-gmapping \
    ros-${ROS_DISTRO}-stage \
    git tmux vim wget gzip

