#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install ROS dependencies for gazebo"

apt-get install -y \
    ros-${ROS_DISTRO}-ros-base 
    git tmux vim wget gzip

