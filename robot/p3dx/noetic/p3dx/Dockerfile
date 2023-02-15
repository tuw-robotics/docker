# enviroment core
# created by Markus Bader <markus.bader@tuwien.ac.at>

ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal
ARG ROOT_CONTAINER=$OWNER/${ROS_DISTRO}-enviroment-core

FROM $ROOT_CONTAINER
USER root

ENV PRJ_DIR=${MY_HOME}/projects/p3dx

RUN apt-get update && apt-get -y upgrade

# Install locale and set
RUN apt-get install -y iputils-ping bash-completion

COPY --chown=${MY_USER}:${MY_USER} ./tmp/p3dx ${MY_PRJ}
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash;  cd ${MY_PRJ};  rosdep update;  rosdep install -i --from-path src --rosdistro noetic -y'
# ros-${ROS_DISTRO}-hokuyo-node
USER ${MY_USER}


    
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; cd ${PRJ_DIR}; catkin_make'
RUN echo 'source ${PRJ_DIR}/devel/setup.bash' >> ~/.bashrc
RUN echo 'roslaunch tuw_p3dx aria_twist.launch'  >> ~/.bash_history
# clean apt
USER root
RUN rm -rf ${MY_HOME}/.ros
#RUN apt-get autoclean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

USER ${MY_USER}
WORKDIR ${PRJ_DIR}
ENV HOME=${MY_HOME}
COPY --chown=${MY_USER}:${MY_USER} ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD [/bin/bash]
