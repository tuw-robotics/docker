# enviroment core
# created by Markus Bader <markus.bader@tuwien.ac.at>

ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal
ARG ROOT_CONTAINER=$OWNER/${ROS_DISTRO}-enviroment-core
FROM $ROOT_CONTAINER


USER root

RUN apt-get update && apt-get -y upgrade

# Install locale and set
RUN apt-get install -y locales apt-utils
USER ${MY_USER}

# clean apt
USER root
#RUN apt-get autoclean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME=${MY_HOME}
CMD /bin/bash
