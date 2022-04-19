#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install ROS dependencies for MR"

apt-get install -y \
    ros-${ROS_DISTRO}-stage \
    git tmux vim wget gzip

