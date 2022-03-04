FROM robotics:base

# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_HOME=/home/${MY_USER}
ARG MY_PASSWORD="xyz"
ARG ROS_DISTRO=noetic
ENV MY_USER ${MY_USER}

ENV PROJECT_ROOT ${MY_HOME}/projects/mrrp

USER root

RUN echo "${MY_USER}:${MY_PASSWORD}" | chpasswd

# Install locale and set
RUN apt-get update &&  apt-get install -y git python3-pip 


# ROS 
RUN apt-get install -y  libdxflib-dev \
						ros-${ROS_DISTRO}-stage-ros \
                        ros-${ROS_DISTRO}-map-server

USER ${MY_USER}
RUN rosdep update

RUN echo "tmux new -s mrrp \; split-window -v \; split-window -v \; select-pane -t 0 \; split-window -v \; select-pane -t 0 \; split-window -h \; select-pane -t 0 \; attach" >> ~/.bash_history
RUN echo "roslaunch tuw_multi_robot_demo demo.launch room:=cave  nr_of_robots:=3 " >> ~/.bash_history
RUN echo "roslaunch tuw_multi_robot_demo demo.launch room:=warehouse032  nr_of_robots:=14" >> ~/.bash_history
RUN echo "roslaunch tuw_multi_robot_demo demo.launch room:=warehouse200  nr_of_robots:=50" >> ~/.bash_history
RUN echo "rosrun tuw_multi_robot_goal_generator goals_random _nr_of_robots:=3 _distance_boundary:=0.6 _distance_to_map_border:=0.2 _nr_of_avaliable_robots:=3" >> ~/.bash_history
RUN echo "rosrun tuw_multi_robot_goal_generator goals_random _nr_of_robots:=32 _distance_boundary:=0.6 _distance_to_map_border:=0.2 _nr_of_avaliable_robots:=14" >> ~/.bash_history
RUN echo "rosrun tuw_multi_robot_goal_generator goals_random _nr_of_robots:=200 _distance_boundary:=0.6 _distance_to_map_border:=0.2 _nr_of_avaliable_robots:=50" >> ~/.bash_history
RUN echo "/opt/TurboVNC/bin/vncserver -localhost -securitytypes NONE :1" >> ~/.bash_history

USER root
ADD ./src/setup_ws.sh   ${INST_SCRIPTS}/setup_ws.sh  
RUN chmod a+x ${INST_SCRIPTS}/setup_ws.sh
USER root
RUN $INST_SCRIPTS/setup_ws.sh  

# clean apt
USER root
RUN rm -rf /var/lib/apt/lists/*
RUN chown -R ${MY_USER}:${MY_USER} ${MY_HOME}


USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash
