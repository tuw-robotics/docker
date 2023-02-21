#!/bin/bash
set -e

# setup ros environment
unset ROS_DISTRO
glow readme.md
exec "$@"
