#!/bin/bash
set -e

# Unsetting ROS_DISTRO to silence ROS_DISTRO override warning
unset ROS_DISTRO
# Setup ROS1 environment
source "/opt/ros/$ROS1_DISTRO/setup.bash" --

# Setup ROS2 bridge environment
source "/root/bridge_ws/install/setup.bash" -- 

exec "$@"
