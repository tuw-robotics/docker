FROM dorowu/ubuntu-desktop-lxde-vnc

    
# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_NAME="Robot"
ARG MY_PASSWORD="holladrio431"
ARG MY_UID=1000
ARG MY_GID=1000
ARG MY_HOME=/home/${MY_USER}
ARG ROS_DISTRO=noetic


RUN apt-get update && apt-get install -y dialog apt-utils

RUN apt-get install -y apt-utils sudo bash-completion &&\
	groupadd -g ${MY_GID} ${MY_USER} && \
    useradd -m -s /bin/bash  -u ${MY_UID} -g ${MY_GID} ${MY_USER}  && \
    export uid=${MY_UID} gid=${MY_GID} && \
    usermod -aG sudo ${MY_USER} && \
    chown ${uid}:${gid} -R ${MY_HOME} && \
    echo "${MY_USER}:${MY_PASSWORD}" | chpasswd
    
RUN apt-get install -y \
    openssh-server \
    tmux \
    vim \
    git \
    dnsutils \
    htop \
    iproute2 \
    iputils-tracepath \
    iputils-ping \
    traceroute \
    mesa-utils 

# Allow root user to login over ssh on port 2222
RUN sed -ri 's/^#?Port\s+.*/Port 2222/' /etc/ssh/sshd_config

# Optimize bashrc
RUN sed -i 's/HISTSIZE=1000/HISTSIZE=20000/g' ${MY_HOME}/.bashrc  && \
    sed -i 's/HISTFILESIZE=2000/HISTFILESIZE=40000/g' ${MY_HOME}/.bashrc

# Copy some configurations
COPY ./utils/tmux.conf ${MY_HOME}/.tmux.conf 


USER root
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt install -y curl
RUN curl -k https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
RUN apt update
RUN apt install -y ros-${ROS_DISTRO}-desktop
RUN apt install -y python3-rosdep

# clean apt
RUN rm -rf /var/lib/apt/lists/*
    

