ARG ROS_DISTRO=humble
ARG OWNER=tuwrobotics
ARG BASE_CONTAINER=ros:${ROS_DISTRO}-desktop 
ARG ROOT_CONTAINER=$OWNER/$BASE_CONTAINER
FROM $ROOT_CONTAINER

# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_NAME="Robot"
ARG MY_PASSWORD="password"
ARG MY_UID=1000
ARG MY_GID=1000
ARG TZ=Europe/Vienna
ENV MY_USER=${MY_USER}
ENV MY_HOME=/home/${MY_USER}

ARG PROJECTS_DIR=${MY_HOME}/projects
ENV PROJECTS_DIR=${PROJECTS_DIR}

ENV CONFIG_DIR=./config
ENV SCRIPTS_DIR=./scripts
ENV INSTALL_DIR=/install

USER root

RUN apt update && apt -y upgrade

# Install locale and set
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y locales apt-utils
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen; locale-gen

# copy scripts to container
COPY ${SCRIPTS_DIR}/ ${INSTALL_DIR}/
# allow to run scripts in the container
RUN chmod -R a+x ${INSTALL_DIR}
# setup user
RUN $INSTALL_DIR/add_user.sh
# install glow a markdown terminal viewer
RUN dpkg -i ${INSTALL_DIR}/glow_1.4.1_linux_amd64.deb

# copy keyboard config
COPY ${CONFIG_DIR}/keyboard/keyboard /etc/default/keyboard
# copy tmux config
COPY ${CONFIG_DIR}/tmux/tmux.conf ${MY_HOME}/.tmux.conf

RUN chown -R ${MY_USER}:${MY_USER} ${MY_HOME}

# install tools (like git, vim, nano, ...)
ARG INSTALL_TERMINAL_TOOLS=true
RUN if [ "$INSTALL_TERMINAL_TOOLS" = "true" ]; then \
        apt-get install -y   \
            cmake            \
            cmake-curses-gui \
            curl             \
            git              \
            gnupg2           \
            keychain         \
            myrepos          \
            nano             \
            python3          \
            python3-pip      \
            rsync            \
            tmux             \
            vim              \
            wget             \
            iproute2         \
            libncurses-dev   \
            tmuxinator       \
            iputils-ping;    \
    fi 

# For Stage
ARG INSTALL_STAGE=true
RUN if [ "$INSTALL_STAGE" = "true" ]; then \
        apt-get install -y libjpeg8-dev libpng-dev libglu1-mesa-dev libltdl-dev libfltk1.1-dev;    \
    fi 

# install xubuntu-desktop
ARG INSTALL_XFCE=true
RUN if [ "$INSTALL_XFCE" = "true" ]; then \
        apt-get install -y --no-install-recommends xubuntu-desktop; \
        apt-get remove -y update-manager; \
        apt-get install -y x11-xkb-utils geany meld wget dbus-x11 xauth; \
    fi 

# install VNC
ARG INSTALL_VNC=true
RUN if [ "$INSTALL_VNC" = "true" ]; then $INSTALL_DIR/install_turbovnc.sh; fi

# install Code (optinal: argument install_code)
ARG INSTALL_VSCODE=true
RUN if [ "$INSTALL_VSCODE" = "true" ]; then $INSTALL_DIR/install_vscode.sh; fi

# install ros tools (ros1 & ros 2)
ARG INSTALL_ROS_TOOLS=true
RUN if [ "$INSTALL_ROS_TOOLS" = "true" ]; then \
        apt-get install -y --no-install-recommends \
            ros-${ROS_DISTRO}-geographic-msgs \
            ros-${ROS_DISTRO}-mavros-msgs \
            ros-${ROS_DISTRO}-xacro \
            ros-${ROS_DISTRO}-joint-state-publisher \
            ros-${ROS_DISTRO}-teleop-tools \
            ros-${ROS_DISTRO}-teleop-twist-joy \
            ros-${ROS_DISTRO}-tf2-tools \
            ros-${ROS_DISTRO}-camera-info-manager \
            ros-${ROS_DISTRO}-urg-node \
            ros-${ROS_DISTRO}-laser-filters \
            ros-${ROS_DISTRO}-laser-geometry; \
    fi

# install ros1 tools
ARG INSTALL_ROS1_TOOLS=true
RUN if [ "$INSTALL_ROS1_TOOLS" = "true" ]; then \
        apt-get install -y ros-${ROS_DISTRO}-gmapping \
            ros-${ROS_DISTRO}-amcl \
            ros-${ROS_DISTRO}-map-server \
            ros-${ROS_DISTRO}-move-base \
            ros-${ROS_DISTRO}-stage \
            ros-${ROS_DISTRO}-navigation; \
    fi

# install ros1 tools
ARG INSTALL_ROS_BRIDGE=false
RUN if [ "$INSTALL_ROS_BRIDGE" = "true" ]; then \
        echo "deb http://packages.ros.org/ros2/ubuntu focal main" > /etc/apt/sources.list.d/ros2-latest.list; \
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
            ros-galactic-ros1-bridge \
            ros-galactic-demo-nodes-cpp \
            ros-galactic-demo-nodes-py; \
    fi

# install ros2 tools
ARG INSTALL_ROS2_TOOLS=true
RUN if [ "$INSTALL_ROS2_TOOLS" = "true" ]; then \
        apt-get install -y --no-install-recommends \
            ros-${ROS_DISTRO}-navigation2 \
            ros-${ROS_DISTRO}-nav2-core \
            ros-${ROS_DISTRO}-nav2-amcl \
            ros-${ROS_DISTRO}-nav2-map-server \
            ros-${ROS_DISTRO}-nav2-lifecycle-manager \
            ros-${ROS_DISTRO}-nav2-costmap-2d \
            ros-${ROS_DISTRO}-test-msgs \
            ros-${ROS_DISTRO}-ament-cmake \
            ros-${ROS_DISTRO}-slam-toolbox \
            ros-${ROS_DISTRO}-mouse-teleop \
            ros-${ROS_DISTRO}-gazebo-ros2-control \
            ros-${ROS_DISTRO}-tf-transformations \
            ros-${ROS_DISTRO}-rmw-fastrtps-cpp \
            ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
            ros-${ROS_DISTRO}-rmw-gurumdds-cpp; \
        python3-pip; \
        pip3 install transforms3d; \
    fi

# install gazebo
ARG INSTALL_GAZEBO=true
RUN if [ "$INSTALL_GAZEBO" = "true" ]; then \
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2486D2DD83DB69272AFE98867170598AF249743; \
        echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-latest.list; \
        wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -; \
        apt-get update; \
        apt-get dist-upgrade; \
        apt-get install -y --no-install-recommends \
            ros-${ROS_DISTRO}-gazebo-ros-pkgs \
            ros-${ROS_DISTRO}-gazebo-ros; \
    fi

RUN apt-get autoclean -y && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${PROJECTS_DIR} && \
    chown -R ${MY_USER}:${MY_USER} ${PROJECTS_DIR}

RUN echo "export PROJECTS_DIR=${PROJECTS_DIR}" >> ~/.bashrc && \
    echo "if [ -f "env.sh" ]; then source env.sh; fi" >> ~/.bashrc && \
    echo "colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Debug" >> ~/.bash_history && \
    echo "cd ${PROJECTS_DIR}" >> ~/.bash_history

# setup entrypoint
COPY ./entrypoint.sh /
COPY ./entrypoint-keep-running.sh /
COPY ./entrypoint-vnc.sh /

USER ${MY_USER}
RUN echo "alias tmux2='tmux new -s mpn \; split-window -v \; attach'" >> ~/.bashrc && \
    echo "export PROJECTS_DIR=${PROJECTS_DIR}" >> ~/.bashrc && \
    echo "export ROS_DISTRO=${ROS_DISTRO}" >> ~/.bashrc && \
    echo "if [ -f "env.sh" ]; then source env.sh; fi" >> ~/.bashrc

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ${PROJECTS_DIR}/env.sh && \
    echo "echo \"** ROS ${ROS_DISTRO} initialized **\"" >> ${PROJECTS_DIR}/env.sh

RUN echo "find -path */.git/config -exec sed -i 's/git@github.com:/https:\/\/github.com\//g' {} +" >> ~/.bash_history && \
    echo "find -path */.git/config -exec sed -i 's/https:\/\/github.com\//git@github.com:/g' {} +" >> ~/.bash_history && \
    echo "cd ${PROJECTS_DIR}" >> ~/.bash_history

COPY --chown=${MY_USER}:${MY_USER} ./info.md ${PROJECTS_DIR}/info.md

# setup entrypoint
ENTRYPOINT ["/entrypoint.sh"]
ENV TERM xterm-256color
WORKDIR ${PROJECTS_DIR}
ENV HOME=${MY_HOME}
CMD /bin/bash
