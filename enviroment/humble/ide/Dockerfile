# enviroment ide
# created by Markus Bader <markus.bader@tuwien.ac.at>
# created by Eugenn Kaltenegger <eugen.kaltenegger@tuwien.ac.at>

ARG UBUNTU_DISTRO=jammy
ARG ROS_DISTRO=humble
ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/$UBUNTU_DISTRO/$ROS_DISTRO
ARG BASE_CONTAINER=$OWNER-enviroment-desktop
FROM $BASE_CONTAINER

ENV SCRIPTS_DIR=./scripts
ENV INSTALL_DIR=/install

USER root

RUN apt-get update 

# copy scripts to container
COPY ${SCRIPTS_DIR}/ ${INSTALL_DIR}/
# allow to run scripts in the container
RUN chmod -R a+x ${INSTALL_DIR}

# install Code (optinal: argument install_code)
ARG INSTALL_CODE=true
RUN if [ "$INSTALL_CODE" = "true" ]; then $INSTALL_DIR/install/ide/install_code.sh; fi
# install KDE-Develop (optinal: argument install_kdevelop)
ARG INSTALL_KDEVELOP=false
RUN if [ "$INSTALL_KDEVELOP" = "true" ]; then $INSTALL_DIR/install/ide/install_kdevelop.sh; fi

USER root
RUN apt-get autoclean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

USER ${MY_USER}

ENV MY_PRJ=${MY_HOME}/projects/ros2/

RUN echo 'rm -rf build install log' >> ~/.bash_history && \     
    echo 'colcon build --symlink-install' >> ~/.bash_history && \      
    echo 'tmux new -s gz \; split-window -v \; select-pane -t 1 \; split-window -v \; select-pane -t 0 \; attach' >> ~/.bash_history

WORKDIR ${MY_PRJ}
ENV HOME=${MY_HOME}
CMD /bin/bash
