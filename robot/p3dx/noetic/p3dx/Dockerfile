# enviroment core
# created by Markus Bader <markus.bader@tuwien.ac.at>

ARG ROS_DISTRO=noetic
ARG OWNER=tuwrobotics
ARG ROOT_CONTAINER=$OWNER/tuw-${ROS_DISTRO}-ide

FROM $ROOT_CONTAINER
USER root

ENV PRJ_DIR=${MY_HOME}/projects/p3dx


RUN apt-get update && apt-get -y upgrade

# Install locale and set
RUN apt-get install -y iputils-ping bash-completion \
						libncurses5-dev \
						ros-noetic-teleop-twist-keyboard \
						ros-noetic-joy ros-noetic-joy-teleop \
						ros-noetic-laser-filters \
						ros-noetic-urg-node \
						libaria-dev
						
COPY --chown=${MY_USER}:${MY_USER} ./tmp/p3dx ${PRJ_DIR}
# RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash;  cd ${PRJ_DIR};  rosdep update;  rosdep install -i --from-path src/rosaria --rosdistro noetic -y'
# RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash;  cd ${PRJ_DIR};  rosdep update;  rosdep install -i --from-path src/tuw_p3dx --rosdistro noetic -y'

USER ${MY_USER}

RUN touch ${PRJ_DIR}/env.sh && \  
    chmod +x ${PRJ_DIR}/env.sh && \ 
    echo 'source /opt/ros/noetic/setup.bash' >> ${PRJ_DIR}/env.sh  && \   
    echo 'echo "** ROS /opt/ros/noetic/setup.bash initialized **"' >> ${PRJ_DIR}/env.sh  && \   
    echo 'source ${PRJ_DIR}/devel/setup.bash' >> ${PRJ_DIR}/env.sh  
    
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; cd ${PRJ_DIR}; pwd; catkin_make'
RUN echo 'source ${PRJ_DIR}/devel/setup.bash' >> ~/.bashrc
RUN echo 'export ROS_MASTER_URI=http://ralf:11311/' >> ~/.bash_history && \     
    echo 'export ROS_MASTER_URI=http://r0:11311/' >> ~/.bash_history && \     
    echo 'roslaunch tuw_launches robot_description.launch'  >> ~/.bash_history  && \   
    echo 'roslaunch tuw_launches laser_hokuyo.launch'  >> ~/.bash_history  && \   
    echo 'roslaunch tuw_launches laser_filter.launch'  >> ~/.bash_history  && \   
    echo 'roslaunch tuw_p3dx aria_twist.launch'  >> ~/.bash_history  && \   
    echo 'roslaunch tuw_p3dx aria_iws.launch'  >> ~/.bash_history  && \    
    echo 'roslaunch tuw_gamepad twist_diffdrive.launch robot_name:=r0'  >> ~/.bash_history

# clean apt
USER root
RUN rm -rf ${MY_HOME}/.ros

USER ${MY_USER}
WORKDIR ${PRJ_DIR}
ENV HOME=${MY_HOME}
COPY --chown=${MY_USER}:${MY_USER} ./ros_aria_twist.sh /
COPY --chown=${MY_USER}:${MY_USER} ./ros_aria_iws.sh /
ENTRYPOINT ["/ros_aria_twist.sh"]
CMD [/bin/bash]
