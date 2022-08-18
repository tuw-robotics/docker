ARG ROS_DISTRO=noetic

ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal
ARG BASE_CONTAINER=$OWNER/noetic-desktop
FROM $BASE_CONTAINER

# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_NAME="Robot"
ARG MY_PASSWORD="password"
ARG MY_UID=1000
ARG MY_GID=1000
ARG TZ=Europe/Vienna

ENV MY_USER=${MY_USER}
ENV MY_HOME=/home/${MY_USER}


ENV CONFIG_DIR=./config
ENV SCRIPTS_DIR=./scripts
ENV INSTALL_DIR=/install

USER root

RUN apt-get update && apt-get -y upgrade

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
RUN $INSTALL_DIR/setup/add_user.sh
# make the user owner of the home directory

# copy bash history
COPY ${CONFIG_DIR}/bash/bash_history ${MY_HOME}/.bash_history
# copy keyboard config
COPY ${CONFIG_DIR}/keyboard/keyboard /etc/default/keyboard
# copy tmux config
COPY ${CONFIG_DIR}/tmux/tmux.conf ${MY_HOME}/.tmux.conf

RUN chown -R ${MY_USER}:${MY_USER} ${MY_HOME}
# install utils (like git, vim, nano, ...)
RUN $INSTALL_DIR/install/install_utils.sh
# install Code (optinal: argument install_code)
ARG INSTALL_CODE=true
RUN if [ "$INSTALL_CODE" = "true" ]; then $INSTALL_DIR/install/ide/install_code.sh; fi
# install Geany (optinal: argument install_geany)
ARG INSTALL_GEANY=true
RUN if [ "$INSTALL_GEANY" = "true" ]; then $INSTALL_DIR/install/ide/install_geany.sh; fi
# install KDE-Develop (optinal: argument install_kdevelop)
ARG INSTALL_KDEVELOP=true
RUN if [ "$INSTALL_KDEVELOP" = "true" ]; then $INSTALL_DIR/install/ide/install_kdevelop.sh; fi
# install VNC (optinal: argmunet install_ssh)
ARG INSTALL_SSH=true
RUN if [ "$INSTALL_SSH" = "true" ]; then $INSTALL_DIR/install/vnc/install_sshc.sh; fi
# install VNC (optinal: argmunet install_vnc)
ARG INSTALL_VNC=true
RUN if [ "$INSTALL_VNC" = "true"  ]; then $INSTALL_DIR/install/vnc/install_turbovnc.sh; fi

USER ${MY_USER}

RUN sed -i 's/01;32/01;31/g' ~/.bashrc # change bash colour to red

# clean apt
USER root
RUN apt-get autoclean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME=${MY_HOME}
CMD /bin/bash
