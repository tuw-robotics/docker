FROM ubuntu:20.04

# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_NAME="Robot"
ARG MY_PASSWORD="holladrio431"
ARG MY_UID=1000
ARG MY_GID=1000
ARG MY_HOME=/home/${MY_USER}
ARG ROS_DISTRO=noetic
ENV MY_USER ${MY_USER}

ENV INST_SCRIPTS=/tmp

USER root
RUN apt update 

ENV TZ=Europe/Vienna
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND noninteractive
COPY ./utils/keyboard /etc/default/keyboard

# Install locale and set
RUN apt-get update &&  apt-get install -y locales apt-utils

# Before installing desktop, set the locale to UTF-8
# see https://stackoverflow.com/questions/28405902/how-to-set-the-locale-inside-a-ubuntu-docker-container
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

ADD ./src/add_user.sh ${INST_SCRIPTS}/add_user.sh
RUN chmod a+x ${INST_SCRIPTS}/add_user.sh
RUN $INST_SCRIPTS/add_user.sh  

ADD ./src/install_turbovnc.sh ${INST_SCRIPTS}/install_turbovnc.sh
RUN chmod a+x ${INST_SCRIPTS}/install_turbovnc.sh
RUN $INST_SCRIPTS/install_turbovnc.sh  

ADD ./src/setup_turbovnc.sh ${INST_SCRIPTS}/setup_turbovnc.sh
RUN chmod a+x ${INST_SCRIPTS}/setup_turbovnc.sh
USER ${MY_USER}
RUN $INST_SCRIPTS/setup_turbovnc.sh  
   
USER root
ADD ./src/install_ide.sh ${INST_SCRIPTS}/install_ide.sh
RUN chmod a+x ${INST_SCRIPTS}/install_ide.sh
RUN $INST_SCRIPTS/install_ide.sh  


USER root
ADD ./src/install_utils.sh ${INST_SCRIPTS}/install_utils.sh
RUN chmod a+x ${INST_SCRIPTS}/install_utils.sh
RUN $INST_SCRIPTS/install_utils.sh


ADD ./src/setup_utils.sh ${INST_SCRIPTS}/setup_utils.sh
RUN chmod a+x ${INST_SCRIPTS}/setup_utils.sh
RUN $INST_SCRIPTS/setup_utils.sh  

# clean apt
USER root
RUN rm -rf /var/lib/apt/lists/*
RUN chown -R ${MY_USER}:${MY_USER} ${MY_HOME}

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash

