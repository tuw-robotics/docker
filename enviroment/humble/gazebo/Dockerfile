# enviroment desktop
# created by Markus Bader <markus.bader@tuwien.ac.at>

ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal/noetic
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
    ros-humble-camera-info-manager \
    ros-humble-gazebo-ros2-control \
    ros-humble-gazebo-ros  \
    ros-humble-ament-cmake \
    ros-humble-xacro \
    ros-humble-joint-state-publisher \
    ros-humble-teleop-tools \
    ros-humble-tf2-tools \
    ros-humble-tf-transformations
    
    
RUN apt-get install -y --no-install-recommends \
    ros-humble-tf-transformations
    
RUN pip3 install transforms3d 
RUN rm -rf /var/lib/apt/lists/*

USER ${MY_USER}

ENV MY_PRJ=${MY_HOME}/projects/gz/

COPY --chown=${MY_USER}:${MY_USER} ./tmp/ws00 ${MY_PRJ}/ws00
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash;  cd ${MY_PRJ}/ws00; colcon build --symlink-install'

COPY --chown=${MY_USER}:${MY_USER} ./tmp/ws01 ${MY_PRJ}/ws01
#RUN /bin/bash -c '. ${MY_PRJ}/ws00/install/setup.bash;  cd ${MY_PRJ}/wws01; colcon build --symlink-install'
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash;  cd ${MY_PRJ}/ws01; colcon build --symlink-install'


COPY --chown=${MY_USER}:${MY_USER} ./env.sh ${MY_PRJ}/env.sh

RUN echo 'ros2 launch tuw_gazebo_models spawn_robot.launch.py model_name:=robot0 robot:=pioneer3dx  X:=-6.0 Y:=-6.0 Theta:=0.7' >> ~/.bash_history  && \   
    echo 'ros2 launch tuw_gazebo world.launch.py room:=cave' >> ~/.bash_history && \     
    echo 'tmux new -s gz \; split-window -v \; select-pane -t 1 \; split-window -v \; select-pane -t 0 \; attach' >> ~/.bash_history

USER ${MY_USER}
WORKDIR ${MY_PRJ}
ENV HOME=${MY_HOME}
CMD /bin/bash
