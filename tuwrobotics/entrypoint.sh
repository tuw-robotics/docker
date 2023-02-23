#!/bin/bash
set -e

# setup ros environment
unset ROS_DISTRO
echo "workspace: $PWD"
glow info.md
exec "$@"
