#!/bin/bash
set -e

# setup ros environment
unset ROS_DISTRO
/opt/TurboVNC/bin/vncserver -localhost -securitytypes NONE :1 
tail -f /dev/null 
exec "$@"
