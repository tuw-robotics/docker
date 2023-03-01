#!/bin/bash

ROS_DISTRO=noetic
OWNER=tuwrobotics
PREFIX=tuw
PROJECT=pathfollowing
HOSTNAME=$(hostname)
IMAGE_NAME=${PREFIX}-${ROS_DISTRO}-${PROJECT}
CONTAINER_NAME=${ROS_DISTRO}-${PROJECT}
CONTAINER_HOSTNAME=${HOSTNAME}-${PROJECT}


docker run --entrypoint /bin/bash -ti --rm --privileged \
	-v ./tmp/ws00/src:/home/robot/projects/ros/pathfollowing/ws00/src \
	-v ./tmp/ws01/src:/home/robot/projects/ros/pathfollowing/ws01/src \
	-v ./tmp/tuw/src:/home/robot/projects/ros/pathfollowing/tuw/src \
	--network="host" --env="DISPLAY" \
	--add-host "${CONTAINER_HOSTNAME}:127.0.0.1" --add-host "r0:10.76.11.50" \
	--hostname ${CONTAINER_HOSTNAME} \
	--device=/dev/ttyS0 \
	--name ${CONTAINER_HOSTNAME} ${OWNER}/${IMAGE_NAME}
