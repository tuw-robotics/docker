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
RUN apt-get install -y \
      xfce4            \
#      xfce4-goodies   \
      xauth            


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

RUN echo "/opt/TurboVNC/bin/vncserver -kill :1" >> ~/.bashrc
RUN echo "/opt/TurboVNC/bin/vncserver -localhost -securitytypes NONE :1" >> ~/.bashrc

# clean apt
USER root
RUN rm -rf /var/lib/apt/lists/*


USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash

