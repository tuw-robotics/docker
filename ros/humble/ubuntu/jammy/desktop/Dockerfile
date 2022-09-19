# ros2 desktop
# created by Markus Bader <markus.bader@tuwien.ac.at>
# based on the https://github.com/osrf/docker_images

ARG UBUNTU_DISTRO=jammy
ARG ROS_DISTRO=humble
ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/$UBUNTU_DISTRO
ARG BASE_CONTAINER=$OWNER/$ROS_DISTRO-base
FROM $BASE_CONTAINER

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-$ROS_DISTRO-desktop=0.10.0-1* \
    ros-$ROS_DISTRO-nav2* \
    ros-$ROS_DISTRO-slam-toolbox 
    
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-$ROS_DISTRO-nav2-common \
    && rm -rf /var/lib/apt/lists/*

