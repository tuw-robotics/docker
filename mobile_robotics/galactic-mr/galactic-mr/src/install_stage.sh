#!/usr/bin/env bash
### every exit != 0 fails the script

echo "Install the Stage Simulator"

apt-get install -y \
    libfltk1.3-dev \
    git tmux vim wget gzip
    
export STAGE_DIR=${MY_HOME}/opt/stage
git clone https://github.com/rtv/Stage.git ${STAGE_DIR}
mkdir ${STAGE_DIR}/build
cd ${STAGE_DIR}/build
cmake ..
make install

chown -R ${MY_USER}:${MY_USER} ${MY_HOME}/opt/stage


mkdir -p ${MY_HOME}/ros2_ws/src
git clone https://github.com/n0nzzz/stage_ros2.git ~/ros2_ws/src/
cd ${MY_HOME}/ros2_ws/

source /opt/ros/${ROS_DISTRO}/setup.bash
colcon build --symlink-install

chown -R ${MY_USER}:${MY_USER} ${MY_HOME}/ros2_ws
