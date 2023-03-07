#!/bin/bash

ROS_DISTRO=noetic
OWNER=tuwrobotics
PREFIX=tuw
PROJECT=ide
HOSTNAME=$(hostname)
IMAGE_NAME=${PREFIX}-${ROS_DISTRO}-${PROJECT}
CONTAINER_NAME=${ROS_DISTRO}-${PROJECT}
CONTAINER_HOSTNAME=${HOSTNAME}-${PROJECT}


docker run --entrypoint /bin/bash -ti --rm --privileged \
	-v $HOME/projects:/home/robot/projects \
	--network="host" --env="DISPLAY" \
	--add-host "${CONTAINER_HOSTNAME}:127.0.0.1" \
	--add-host "r0:10.76.11.50" \
	--add-host "ralf:10.76.11.80" \
	--hostname ${CONTAINER_HOSTNAME} \
	--name ${CONTAINER_HOSTNAME} ${OWNER}/${IMAGE_NAME}
