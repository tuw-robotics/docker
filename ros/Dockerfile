FROM noetic:tuw_base

ARG ROS_VERSION=noetic
ARG MY_USER=robot
ARG MY_HOME=/home/${MY_USER}

USER root
RUN chown ${MY_USER}:${MY_USER} -R ${MY_HOME}

USER ${MY_USER}
RUN mkdir -p ${HOME}/projects/ws_multi_robot/src && \
	cd ${HOME}/projects/ws_multi_robot/src  && \
	git clone --branch ${ROS_VERSION} https://github.com/tuw-robotics/tuw_multi_robot.git
    
USER root
RUN /bin/bash -c "source ${MY_HOME}/projects/ws_base/devel/setup.bash && \
	cd ${MY_HOME}/projects/ws_multi_robot/ &&  \
	apt-get update && \
	rosdep update && \
	rosdep install --from-paths src --ignore-src -r -y && \
	chown -R ${MY_USER}:${MY_USER} ${MY_HOME}/.ros" 
	
# clean apt
RUN rm -rf /var/lib/apt/lists/*
	
USER ${MY_USER}
RUN /bin/bash -c "source ${MY_HOME}/projects/ws_base/devel/setup.bash && \
	cd ${HOME}/projects/ws_multi_robot && \
	catkin_make" 

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash
