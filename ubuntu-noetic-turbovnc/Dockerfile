FROM ubuntu:noetic

ARG    TURBOVNC_VERSION="2.2.6"
ENV    RES "1920x1080"

# Replace 1000 with your user / group id
ARG MY_USER=robot
ARG MY_HOME=/home/${MY_USER}
ARG ROS_DISTRO=noetic
ENV MY_USER ${MY_USER}

USER root

# Install locale and set
RUN apt-get update

# Install libraries/dependencies
RUN apt-get install -y --no-install-recommends xubuntu-desktop

# Turbovnc
## Install VNC
RUN wget "https://sourceforge.net/projects/turbovnc/files/${TURBOVNC_VERSION}/turbovnc_${TURBOVNC_VERSION}_amd64.deb/download" -O /opt/turbovnc.deb && \
    dpkg -i /opt/turbovnc.deb && \
    rm -f /opt/turbovnc.deb

USER ${MY_USER}
## Setup VNC password
RUN mkdir ${MY_HOME}/.vnc
COPY ./utils/vnc/xstartup.turbovnc ${MY_HOME}/.vnc/xstartup.turbovnc
RUN  /usr/bin/printf '%s\n%s\n%s\n' 'password' 'password' 'n' | /opt/TurboVNC/bin/vncpasswd
RUN  echo -n 'password\npassword\nn\n' | /opt/TurboVNC/bin/vncpasswd

# Remove keyboard shortcut to allow bash_completion in xfce4-terminal
RUN echo "DISPLAY=:1 xfconf-query -c xfce4-keyboard-shortcuts -p \"/xfwm4/custom/<Super>Tab\" -r" >> ${MY_HOME}/.bashrc

RUN echo "/opt/TurboVNC/bin/vncserver -kill :1" >> ~/.bash_history
RUN echo "/opt/TurboVNC/bin/vncserver -localhost -securitytypes NONE :1" >> ~/.bash_history
RUN echo "exit" >> ~/.bash_history

# clean apt
USER root
RUN rm -rf /var/lib/apt/lists/*
RUN chown -R ${MY_USER}:${MY_USER} ${MY_HOME}


# Kdevelop
RUN apt-get update
RUN apt-get install -y \
      kdevelop         \          
      geany     
            
# VS Code 
RUN apt install -y software-properties-common apt-transport-https wget
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
RUN apt-get update
RUN apt install code

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash

