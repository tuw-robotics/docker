# ros2 bridge using tuw msgs
# created by Markus Bader <markus.bader@tuwien.ac.at>
# extended by Daniel Harringer <daniel.harringer@tuwien.ac.at>
# based on the https://github.com/osrf/docker_images

ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal
ARG BASE_CONTAINER=$OWNER/galactic-base
FROM $BASE_CONTAINER

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros1-latest.list

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

ENV ROS1_DISTRO noetic
ENV ROS1_WS /root/ros1_ws

ENV ROS2_DISTRO galactic
ENV ROS2_WS /root/ros2_ws

ENV BRIDGE_WS /root/bridge_ws

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-ros-comm=1.15.14-1* \
    ros-noetic-geometry-msgs \
    ros-noetic-actionlib \
    ros-noetic-nav-msgs \
    ros-noetic-tf \
    && rm -rf /var/lib/apt/lists/*

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-galactic-demo-nodes-cpp=0.14.3-1* \
    ros-galactic-demo-nodes-py=0.14.3-1* \
    && rm -rf /var/lib/apt/lists/*

# Create ROS1 workspace and clone the message repo
RUN mkdir -p ${ROS1_WS}/src
WORKDIR ${ROS1_WS}/src

# Clone every message you want bridge to the ROS2 
RUN git clone -b ${ROS1_DISTRO} --single-branch https://github.com/tuw-robotics/tuw_msgs.git
##### Add more custom messages here (ROS 1) #####


# Build the ROS1 WS
WORKDIR ${ROS1_WS}
RUN /bin/bash -c   "unset ROS_DISTRO && \
                    source /opt/ros/${ROS1_DISTRO}/setup.bash && \
                    catkin_make"


# Create ROS2 workspace and clone the message repo
RUN mkdir -p ${ROS2_WS}/src
WORKDIR  ${ROS2_WS}/src

# Clone every message you want bridge to the ROS2 
RUN git clone -b ros2 --single-branch https://github.com/tuw-robotics/tuw_msgs.git
##### Add more custom messages here (ROS 2) #####


# Build the ROS2 WS
WORKDIR ${ROS2_WS}/
RUN /bin/bash -c   "unset ROS_DISTRO && \
                    source /opt/ros/${ROS2_DISTRO}/local_setup.bash && \
                    colcon build --symlink-install"


# Create Bridge workspace and clone the message repo
RUN mkdir -p ${BRIDGE_WS}/src
WORKDIR ${BRIDGE_WS}/src
RUN git clone -b master --single-branch https://github.com/ros2/ros1_bridge.git

# Build the Bridge WS
WORKDIR ${BRIDGE_WS}
RUN /bin/bash -c   "unset ROS_DISTRO && \
                    source /opt/ros/${ROS1_DISTRO}/setup.bash && \
                    source /opt/ros/${ROS2_DISTRO}/setup.bash && \
                    source ~/ros1_ws/devel/setup.bash && \
                    source ~/ros2_ws/install/setup.bash && \
                    colcon build --symlink-install --packages-select ros1_bridge --cmake-force-configure"
WORKDIR /

# Setup entrypoint
COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
