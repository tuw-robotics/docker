FROM ubuntu:20.04

ARG    TURBOVNC_VERSION="2.2.6"
ENV    RES "1920x1080"

# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_NAME="Robot"
ARG MY_PASSWORD="holladrio431"
ARG MY_UID=1000
ARG MY_GID=1000
ARG MY_HOME=/home/${MY_USER}
ARG ROS_DISTRO=noetic
ENV MY_USER ${MY_USER}

ENV TZ=Europe/Vienna
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND noninteractive
COPY ./utils/keyboard /etc/default/keyboard

# Install locale and set
RUN apt-get update &&  apt-get install -y locales apt-utils

# Before installing desktop, set the locale to UTF-8
# see https://stackoverflow.com/questions/28405902/how-to-set-the-locale-inside-a-ubuntu-docker-container
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get install -y apt-utils sudo bash-completion &&\
	groupadd -g ${MY_GID} ${MY_USER} && \
    useradd -m -s /bin/bash  -u ${MY_UID} -g ${MY_GID} ${MY_USER}  && \
    export uid=${MY_UID} gid=${MY_GID} && \
    usermod -aG sudo ${MY_USER} && \
    chown ${uid}:${gid} -R ${MY_HOME} && \
    echo "${MY_USER}:${MY_PASSWORD}" | chpasswd

# Install libraries/dependencies
RUN apt-get install -y \
      openssh-server   \
      cmake            \
      vim              \
      wget             \
      tmux             \
      rsync            \
      xfce4            \
#      xfce4-goodies   \
      xauth            

# Setup tmux some configurations
COPY ./utils/tmux.conf ${MY_HOME}/.tmux.conf 

# Optimize bashrc
RUN sed -i 's/HISTSIZE=1000/HISTSIZE=20000/g' ${MY_HOME}/.bashrc  && \
    sed -i 's/HISTFILESIZE=2000/HISTFILESIZE=40000/g' ${MY_HOME}/.bashrc

# Allow root user to login over ssh on port 2222
RUN sed -ri 's/^#?Port\s+.*/Port 2222/' /etc/ssh/sshd_config

# Turbovnc
## Install VNC
RUN wget "https://sourceforge.net/projects/turbovnc/files/${TURBOVNC_VERSION}/turbovnc_${TURBOVNC_VERSION}_amd64.deb/download" -O /opt/turbovnc.deb && \
    dpkg -i /opt/turbovnc.deb && \
    rm -f /opt/turbovnc.deb

## Setup VNC password
RUN mkdir ${MY_HOME}/.vnc
COPY ./utils/vnc/xstartup.turbovnc ${MY_HOME}/.vnc/xstartup.turbovnc
RUN  chown -R ${MY_USER} ${MY_HOME}/.vnc && \
    /usr/bin/printf '%s\n%s\n%s\n' 'password' 'password' 'n' | su ${MY_USER} -c /opt/TurboVNC/bin/vncpasswd
RUN  echo -n 'password\npassword\nn\n' | su ${MY_USER} -c /opt/TurboVNC/bin/vncpasswd

# Remove keyboard shortcut to allow bash_completion in xfce4-terminal
RUN echo "DISPLAY=:1 xfconf-query -c xfce4-keyboard-shortcuts -p \"/xfwm4/custom/<Super>Tab\" -r" >> ${MY_HOME}/.bashrc

COPY ./utils/bash_history ${MY_HOME}/.bash_history


# ROS
USER root
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt install -y curl
RUN curl -k https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
RUN apt update
RUN apt install -y ros-${ROS_DISTRO}-desktop
RUN apt install -y python3-rosdep

# clean apt
RUN rm -rf /var/lib/apt/lists/*


USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash

