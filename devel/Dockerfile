FROM mxcar:base

ARG ROS_VERSION=noetic
ARG MY_USER=robot
ARG MY_HOME=/home/${MY_USER}

USER root

# Install locale and set
RUN apt-get update &&  apt-get install -y geany

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash
