#!/bin/bash
set -e

# setup ros environment
unset ROS_DISTRO
tail -f /dev/null 
exec "$@"
