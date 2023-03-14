ARG ROS_DISTRO=noetic
ARG OWNER=tuwrobotics
ARG ROOT_CONTAINER=$OWNER/tuw-${ROS_DISTRO}-ide

FROM $ROOT_CONTAINER
USER root

RUN apt-get update && apt-get -y upgrade

# Install locale and set
RUN apt-get install -y iputils-ping bash-completion

ENV PROJECT_DIR=${MY_HOME}/projects
RUN mkdir -p ${PROJECT_DIR}

USER root
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; rosdep update;'

COPY --chown=${MY_USER}:${MY_USER} ./source/ws00/src ${PROJECT_DIR}/ws00/src
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; cd ${PROJECT_DIR}/ws00; rosdep install -y -i --from-path src --rosdistro noetic'
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; cd ${PROJECT_DIR}/ws00; catkin_make'

COPY --chown=${MY_USER}:${MY_USER} ./source/ws01/src ${PROJECT_DIR}/ws01/src
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; source ${PROJECT_DIR}/ws00/devel/setup.bash; cd ${PROJECT_DIR}/ws01; rosdep install -y -i --from-path src --rosdistro noetic --skip-keys=tuw_nav_msgs'
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; source ${PROJECT_DIR}/ws00/devel/setup.bash; cd ${PROJECT_DIR}/ws01; catkin_make'

USER ${MY_USER}

RUN echo 'source ${PROJECT_DIR}/ws00/devel/setup.bash' >> ~/.bashrc
RUN echo 'source ${PROJECT_DIR}/ws01/devel/setup.bash' >> ~/.bashrc
RUN echo 'alias hints="glow ~/info.md"' >> ~/.bashrc
RUN echo 'alias e="exit"' >> ~/.bashrc
RUN echo 'alias c="clear"' >> ~/.bashrc
RUN echo 'roslaunch tuw_iwos_launches robot.launch gamepad:=true' >> ~/.bash_history
RUN echo 'tmux new-session \; split-window -h \; split-window -v \; attach \;' >> ~/.bash_history

USER root
RUN rm -rf ${MY_HOME}/.ros

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME=${MY_HOME}
COPY --chown=${MY_USER}:${MY_USER} info.md ${MY_HOME}/info.md
CMD /bin/bash
