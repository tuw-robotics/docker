FROM robotics:base

# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_HOME=/home/${MY_USER}
ARG ROS_DISTRO=noetic
ENV MY_USER ${MY_USER}
ENV MR_DIR /home/${MY_USER}/projects/mr
ENV INST_SCRIPTS=/tmp

USER root
ADD ./src/ ${INST_SCRIPTS}/
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +


USER root
RUN apt-get update
RUN $INST_SCRIPTS/install_ros.sh  

USER ${MY_USER}
RUN mkdir -p ${MR_DIR}/src/
COPY ./utils/kdev.tar.gz ${MR_DIR}/src/
COPY ./utils/stage_ros-20.04.tar.gz ${MR_DIR}/src/
COPY ./utils/mr2021.tar.gz ${MR_DIR}/src/
RUN cd ${MR_DIR}/src &&  \
	tar -xzvf kdev.tar.gz &&  \
	tar -xzvf mr2021.tar.gz  &&  \
	tar -xzvf stage_ros-20.04.tar.gz
	
RUN $INST_SCRIPTS/setup_mr.sh  

RUN echo "tmux new -s mpn \; split-window -v \; split-window -v \; select-pane -t 0 \; split-window -v \; select-pane -t 0 \; split-window -h \; select-pane -t 0 \; attach" >> ~/.bash_history
RUN echo "catkin_make -DCMAKE_BUILD_TYPE=Debug" >> ~/.bash_history
RUN echo "rosrun rqt_reconfigure rqt_reconfigure" >> ~/.bash_history
RUN echo "roslaunch stage_ros world.launch world:=cave.world" >> ~/.bash_history
RUN echo "roslaunch mr_local_planner planner_multi.launch stage:=1 world:=cave.world mode:=1" >> ~/.bash_history

# clean apt
USER root
RUN rm -rf /var/lib/apt/lists/*
RUN chown -R ${MY_USER}:${MY_USER} ${MY_HOME}

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash

