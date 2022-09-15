# enviroment core
# created by Markus Bader <markus.bader@tuwien.ac.at>
# created by Eugenn Kaltenegger <eugen.kaltenegger@tuwien.ac.at>

ARG UBUNTU_DISTRO=jammy
ARG ROS_DISTRO=humble
ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/$UBUNTU_DISTRO
ARG ROOT_CONTAINER=$OWNER/$ROS_DISTRO-desktop
FROM $ROOT_CONTAINER

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

# copy bashrc
COPY ${CONFIG_DIR}/bash/bashrc ${MY_HOME}/.bashrc
# copy env
COPY ${CONFIG_DIR}/bash/env.sh ${MY_HOME}/projects/env.sh
# copy bash history
COPY ${CONFIG_DIR}/bash/bash_history ${MY_HOME}/.bash_history
# copy keyboard config
COPY ${CONFIG_DIR}/keyboard/keyboard /etc/default/keyboard
# copy tmux config
COPY ${CONFIG_DIR}/tmux/tmux.conf ${MY_HOME}/.tmux.conf

RUN chown -R ${MY_USER}:${MY_USER} ${MY_HOME}
# install utils (like git, vim, nano, ...)
RUN apt-get install -y     \
      cmake            \
      cmake-curses-gui \
      curl             \
      git              \
      gnupg2           \
      keychain         \
      myrepos          \
      nano             \
      python3          \
      python3-pip      \
      rsync            \
      tmux             \
      vim              \
      wget             \
      iputils-ping
      
RUN apt-get install -y openssh-server
RUN sed -ri 's/^#?Port\s+.*/Port 2222/' /etc/ssh/sshd_config

# clean apt
USER root
RUN apt-get autoclean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME=${MY_HOME}
CMD /bin/bash
