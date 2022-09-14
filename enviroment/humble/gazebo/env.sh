#export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
#export RMW_IMPLEMENTATION=rmw_gurumdds_cpp
#export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

#source /usr/share/colcon_cd/function/colcon_cd.sh
#export _colcon_cd_root=/opt/ros/$ROS_DISTRO/
#source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash

source /opt/ros/$ROS_DISTRO/setup.bash
echo "** ROS2 $ROS_DISTRO initialized with $RMW_IMPLEMENTATION**"
source ${HOME}/projects/gz/ws01/install/setup.bash
