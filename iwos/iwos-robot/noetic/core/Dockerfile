
ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal
ARG ROOT_CONTAINER=$OWNER/${ROS_DISTRO}-enviroment-core

FROM ubuntu as intermediate

# install git
RUN apt-get update
RUN apt-get install -y git

# add credentials on build
ARG SSH_PRIVATE_KEY
RUN mkdir /root/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Add git providers to known_hosts
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN git clone --branch master git@github.com:tuw-robotics/tuw_geometry.git         catkin_ws/src/tuw_geometry
RUN git clone --branch noetic git@github.com:tuw-robotics/tuw_msgs.git             catkin_ws/src/tuw_msgs
RUN git clone --branch devel-python git@github.com:tuw-robotics/tuw_teleop.git     catkin_ws/src/tuw_teleop

RUN git clone --branch devel git@github.com:ek-robotics/tuw_iwos.git               catkin_ws/src/tuw_iwos
RUN git clone --branch devel git@github.com:ek-robotics/tuw_hardware_interface.git catkin_ws/src/tuw_hardware_interface

FROM $ROOT_CONTAINER
USER root

ENV PROJECT_DIR=${MY_HOME}/projects/catkin_ws

RUN apt-get update && apt-get -y upgrade

# Install locale and set
RUN apt-get install -y iputils-ping bash-completion

COPY --chown=${MY_USER}:${MY_USER} --from=intermediate /catkin_ws  ${PROJECT_DIR}
COPY --chown=${MY_USER}:${MY_USER} --from=intermediate /root/.ssh ${MY_HOME}/.ssh

RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; rosdep update;'
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; cd ${PROJECT_DIR}; rosdep install -y -i --from-path src --rosdistro noetic --skip-keys=tuw_nav_msgs'

USER ${MY_USER}
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; cd ${PROJECT_DIR}; catkin_make'
RUN echo 'source ${PROJECT_DIR}/devel/setup.bash' >> ~/.bashrc

COPY --chown=${MY_USER}:${MY_USER} ./entrypoint.md ${MY_HOME}/entrypoint.md

USER root
RUN rm -rf ${MY_HOME}/.ros

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME=${MY_HOME}
COPY --chown=${MY_USER}:${MY_USER} ./entrypoint.md ${MY_HOME}/
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD /bin/bash
