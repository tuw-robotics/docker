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
