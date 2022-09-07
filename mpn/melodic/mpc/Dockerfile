ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/bionic/melodic
ARG ROOT_CONTAINER=$OWNER/${ROS_DISTRO}-pathfollowing

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
   
RUN git clone --branch master  git@github.com:tuw-robotics/tuw_diffdrive.git        mpn/ws03/src/tuw_diffdrive
RUN git clone --branch master  git@github.com:tuw-robotics/tuw_mpn.git              mpn/ws03/src/tuw_mpn
RUN git clone --branch master  git@github.com:tuw-robotics/tuw_nav_costmap.git      mpn/ws03/src/tuw_nav_costmap

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

COPY --chown=${MY_USER}:${MY_USER} --from=intermediate /mpn ${MY_HOME}/projects/mpn
    
RUN /bin/bash -c '. ${MY_HOME}/projects/mpn/ws02/devel/setup.bash; cd ${MY_HOME}/projects/mpn/ws03; catkin_make -Doptizelle_ROOT_DIR=/opt/Optizelle -DFMM_DIR=/opt/fastmarching/share/FMM'

RUN /bin/bash -c '. ${MY_HOME}/projects/mpn/ws03/devel/setup.bash; cd ${MY_HOME}/projects/mpn/tuw; catkin_make'


                       
USER root
RUN rm -rf /var/lib/apt/lists/*

USER ${MY_USER}
WORKDIR ${MY_HOME}
ENV HOME ${MY_HOME}
CMD /bin/bash
