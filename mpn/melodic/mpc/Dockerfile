ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/bionic/melodic
ARG ROOT_CONTAINER=$OWNER/noetic-desktop

FROM $ROOT_CONTAINER

ENV INST_SCRIPTS=/tmp
ENV SRC_DIR=./mpn

ENV PROJECT_ROOT ${MY_HOME}/projects/mpn

USER root


# Install locale and set
RUN apt-get update &&  apt-get install -y git python3-pip \
   libmgl-dev libjsoncpp-dev autoconf libncurses5-dev libdxflib-dev \
   libgoogle-perftools-dev gperf

# ROS 
RUN apt-get install -y \
    ros-${ROS_DISTRO}-costmap-2d \
    ros-${ROS_DISTRO}-octomap \
    ros-${ROS_DISTRO}-octomap-msgs \
    ros-${ROS_DISTRO}-amcl \
    ros-${ROS_DISTRO}-laser-filters \
    ros-${ROS_DISTRO}-bfl \
    ros-${ROS_DISTRO}-cv-bridge \
    ros-${ROS_DISTRO}-move-base-msgs \
    ros-${ROS_DISTRO}-nav-core \
    ros-${ROS_DISTRO}-navfn \
    ros-${ROS_DISTRO}-map-server \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-robot-state-publisher \
    ros-${ROS_DISTRO}-pcl-ros  \
    ros-${ROS_DISTRO}-pcl-conversions \
    ros-${ROS_DISTRO}-rviz \
    ros-${ROS_DISTRO}-marker-msgs \
    ros-${ROS_DISTRO}-stage-ros
    
    
RUN mkdir -p /opt/fastmarching && \
    git clone https://github.com/tuw-robotics/fastmarching.git  /opt/fastmarching/source && \
    mkdir -p /opt/fastmarching/source/build  && \
    cd /opt/fastmarching/source/build  && \
	cmake .. \
		  -DCMAKE_INSTALL_PREFIX=/opt/fastmarching/ \
		  -DCMAKE_BUILD_TYPE=Release && \
    make install && \
    cd .. && \
    rm -rf build 
    
RUN apt install -y libjsoncpp-dev libblas-dev liblapack-dev gfortran && \
    mkdir -p /opt/Optizelle && \
    git clone https://github.com/tuw-robotics/Optizelle.git  /opt/Optizelle/source && \
    mkdir -p /opt/Optizelle/source/build && \
    cd /opt/Optizelle/source/build && \
    cmake .. \
      -DCMAKE_INSTALL_PREFIX=/opt/Optizelle/ \
      -DCMAKE_BUILD_TYPE=Release \
      -DENABLE_BUILD_JSONCPP=OFF \
      -DJSONCPP_INCLUDE_DIR=/usr/include/jsoncpp \
      -DJSONCPP_LIBRARY=/usr/lib/x86_64-linux-gnu/libjsoncpp.so && \
    make install && \
    cd .. && \
    rm -rf build 
    

# COPY --chown=${MY_USER}:${MY_USER} ./git/ ${MY_HOME}/projects/mpn/
USER ${MY_USER}

## ws00
COPY --chown=${MY_USER}:${MY_USER} ./tmp/ws00 ${MY_HOME}/projects/mpn/ws00
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash;             cd ${MY_HOME}/projects/mpn/ws00; catkin_make -DCMAKE_BUILD_TYPE=Release'

## ws01
COPY --chown=${MY_USER}:${MY_USER} ./tmp/ws01 ${MY_HOME}/projects/mpn/ws01
RUN /bin/bash -c '. ${MY_HOME}/projects/mpn/ws00/devel/setup.bash; cd ${MY_HOME}/projects/mpn/ws01; catkin_make -DCMAKE_BUILD_TYPE=Release'

## ws02
COPY --chown=${MY_USER}:${MY_USER} ./tmp/ws02 ${MY_HOME}/projects/mpn/ws02
RUN rm ${MY_HOME}/projects/mpn/ws02/src/tuw_rviz/tuw_control_rviz/CATKIN_IGNORE
RUN /bin/bash -c '. ${MY_HOME}/projects/mpn/ws01/devel/setup.bash; cd ${MY_HOME}/projects/mpn/ws02; catkin_make -DCMAKE_BUILD_TYPE=Release'

## ws03
COPY --chown=${MY_USER}:${MY_USER} ./tmp/ws03 ${MY_HOME}/projects/mpn/ws03
RUN /bin/bash -c '. ${MY_HOME}/projects/mpn/ws02/devel/setup.bash; cd ${MY_HOME}/projects/mpn/ws03; catkin_make -DCMAKE_BUILD_TYPE=Release -Doptizelle_ROOT_DIR=/opt/Optizelle -DFMM_DIR=/opt/fastmarching/share/FMM'

## tuw
COPY --chown=${MY_USER}:${MY_USER} ./tmp/tuw  ${MY_HOME}/projects/mpn/tuw
RUN /bin/bash -c '. ${MY_HOME}/projects/mpn/ws03/devel/setup.bash; cd ${MY_HOME}/projects/mpn/tuw; catkin_make -DCMAKE_BUILD_TYPE=Release'

RUN echo 'source ${MY_HOME}/projects/mpn/tuw/devel/setup.bash' >> ~/.bashrc

RUN echo 'roslaunch tuw_launches mpn_nodelet.launch cfg:=p3dx' >> ~/.bash_history && \
    echo 'roslaunch tuw_launches rviz_navigation.launch' >> ~/.bash_history  && \        
    echo 'roslaunch tuw_launches navigation.launch launch_safety_constraints:=false use_localization:=true debug:=true room:=roblab launch_mpn:=false' >> ~/.bash_history  && \        
    echo 'roslaunch tuw_launches laser_filter.launch robot_name:=r0' >> ~/.bash_history && \
    echo 'tmux new -s mpn \; split-window -v \; split-window -v \; select-pane -t 0 \; split-window -v \; select-pane -t 0 \; attach' >> ~/.bash_history
    
                       
USER root
RUN rm -rf /var/lib/apt/lists/*

USER ${MY_USER}
WORKDIR ${MY_HOME}/projects/mpn/tuw
ENV HOME ${MY_HOME}
CMD /bin/bash
