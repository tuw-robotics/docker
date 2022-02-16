FROM robotics:base

# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_HOME=/home/${MY_USER}
ARG MY_PASSWORD="xyz"
ARG ROS_DISTRO=noetic
ENV MY_USER ${MY_USER}

ENV PROJECT_ROOT ${MY_HOME}/projects/iwos

USER root

RUN echo "${MY_USER}:${MY_PASSWORD}" | chpasswd

# Install locale and set
RUN apt-get update &&  apt-get install -y git python3-pip 


USER ${MY_USER}
RUN rosdep update

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
