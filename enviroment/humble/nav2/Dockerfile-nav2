# enviroment desktop
# created by Markus Bader <markus.bader@tuwien.ac.at>

ARG UBUNTU_DISTRO=jammy
ARG ROS_DISTRO=humble
ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/$UBUNTU_DISTRO/$ROS_DISTRO
ARG BASE_CONTAINER=$OWNER-enviroment-core
FROM $BASE_CONTAINER

USER root


# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2486D2DD83DB69272AFE98867170598AF249743

# setup sources.list
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-latest.list && \
    wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -



RUN apt-get update
RUN apt-get -y dist-upgrade

RUN apt-get install -y --no-install-recommends \
    gazebo \
    ros-$ROS_DISTRO-camera-info-manager \
    ros-$ROS_DISTRO-gazebo-ros2-control \
    ros-$ROS_DISTRO-gazebo-ros  \
    ros-$ROS_DISTRO-ament-cmake \
    ros-$ROS_DISTRO-xacro \
    ros-$ROS_DISTRO-joint-state-publisher \
    ros-$ROS_DISTRO-teleop-tools \
    ros-$ROS_DISTRO-tf2-tools \
    ros-$ROS_DISTRO-tf-transformations
    
    
RUN apt-get install -y --no-install-recommends \
    ros-$ROS_DISTRO-tf-transformations
    
RUN pip3 install transforms3d 
RUN rm -rf /var/lib/apt/lists/*

USER ${MY_USER}

ENV MY_PRJ=${MY_HOME}/projects/ros2/nav2/

COPY --chown=${MY_USER}:${MY_USER} ./tmp/ws00 ${MY_PRJ}/ws00
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash;  cd ${MY_PRJ}/ws00; colcon build --symlink-install'

COPY --chown=${MY_USER}:${MY_USER} ./tmp/ws01 ${MY_PRJ}/ws01
#RUN /bin/bash -c '. ${MY_PRJ}/ws00/install/setup.bash;  cd ${MY_PRJ}/wws01; colcon build --symlink-install'
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash;  cd ${MY_PRJ}/ws01; colcon build --symlink-install'


COPY --chown=${MY_USER}:${MY_USER} ./env.sh ${MY_PRJ}/env.sh

RUN echo 'ros2 run mouse_teleop mouse_teleop --ros-args --remap mouse_vel:=cmd_vel' >> ~/.bash_history && \     
    echo 'tmux new -s gz \; split-window -v \; select-pane -t 1 \; split-window -v \; select-pane -t 0 \; attach' >> ~/.bash_history

USER ${MY_USER}
WORKDIR ${MY_PRJ}
ENV HOME=${MY_HOME}
CMD /bin/bash
