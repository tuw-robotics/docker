#!/bin/bash
set -e

source "/opt/ros/$ROS_DISTRO/setup.bash"
source "${PROJECT_DIR}/devel/setup.bash"

# setup ros environment
glow ~/entrypoint.md
exec "$@"
