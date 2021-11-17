FROM ubuntu-noetic:turbovnc

# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_HOME=/home/${MY_USER}
ARG ROS_DISTRO=noetic
ENV MY_USER ${MY_USER}


ENV PROJECT_ROOT ${MY_USER}/projects/iwos

USER root
# Install locale and set
RUN apt-get update &&  apt-get install -y git

USER ${MY_USER}
RUN mkdir -p ${PROJECT_ROOT}/ws00/src
RUN cd ${PROJECT_ROOT}/ws00/src  && \
	git clone https://github.com/tuw-robotics/tuw_msgs.git && \
	git clone -b devel-iwos https://github.com/tuw-robotics/tuw_teleop.git
	

# clean apt
USER root
RUN rm -rf /var/lib/apt/lists/*
RUN chown -R ${MY_USER}:${MY_USER} ${MY_HOME}


USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash

