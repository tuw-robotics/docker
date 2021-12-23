FROM osrf/ros:noetic-desktop

# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_NAME="Robot"
ARG MY_PASSWORD="holladrio431"
ARG MY_UID=1000
ARG MY_GID=1000
ARG ROS_DISTRO=noetic
ARG TZ=Europe/Vienna

ENV MY_USER=${MY_USER}
ENV MY_HOME=/home/${MY_USER}
ENV ROS_DISTRO=${ROS_DISTRO}
ENV INST_SCRIPTS=/tmp

USER root
RUN apt-get update && apt-get -y upgrade

# Install locale and set
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y locales apt-utils
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY ./utils/keyboard /etc/default/keyboard
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen; locale-gen

# Add user
ADD ./src/add_user.sh ${INST_SCRIPTS}/add_user.sh
RUN chmod a+x ${INST_SCRIPTS}/add_user.sh
RUN $INST_SCRIPTS/add_user.sh  

# Add VNC-Server
USER root
ADD ./src/install_turbovnc.sh ${INST_SCRIPTS}/install_turbovnc.sh
RUN chmod a+x ${INST_SCRIPTS}/install_turbovnc.sh
RUN $INST_SCRIPTS/install_turbovnc.sh  
   
# Install programming enviroments 
USER root
ADD ./src/install_ide.sh ${INST_SCRIPTS}/install_ide.sh
RUN chmod a+x ${INST_SCRIPTS}/install_ide.sh
RUN $INST_SCRIPTS/install_ide.sh  


# Install some utils like vim, tmux, git, ...
USER root
ADD ./src/install_utils.sh ${INST_SCRIPTS}/install_utils.sh
RUN chmod a+x ${INST_SCRIPTS}/install_utils.sh
RUN $INST_SCRIPTS/install_utils.sh


# clean apt
USER root
RUN rm -rf /var/lib/apt/lists/*
RUN chown -R ${MY_USER}:${MY_USER} ${MY_HOME}

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash

