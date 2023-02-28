ROS_DISTRO = noetic
OWNER = tuwrobotics
PREFIX = tuw
ROOT_CONTAINER = ${OWNER}/${PREFIX}-${ROS_DISTRO}-ide

PROJECT = p3dx
PROJECT_DIR = $(shell pwd)
HOSTNAME := $(shell hostname)
IMAGE_NAME=${PREFIX}-${ROS_DISTRO}-${PROJECT}
CONTAINER_NAME=${ROS_DISTRO}-${PROJECT}
CONTAINER_HOSTNAME=${HOSTNAME}-${PROJECT}

all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   make build              - build the images ${IMAGE_NAME}"
	@echo "   make login USER=mbader  - authenticate container Registry"
	@echo "   make pull               - pull all images"
	@echo "   make push               - push all images"
	@echo "   make clean              - remove all images"
	@echo "   make run                - runs the image"
	@echo ""

login:
	@docker login registry.auto.tuwien.ac.at -u ${USER}
	
build:
	@docker build --rm -t ${OWNER}/${IMAGE_NAME}  --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}  p3dx/.
	
push:
	@docker push ${OWNER}/${IMAGE_NAME}
	
pull:
	@docker pull ${OWNER}/${IMAGE_NAME}

clean:
	@docker rmi -f ${OWNER}/${IMAGE_NAME}

run-twist:
	@docker run -ti --rm --privileged \
	--network="host" --env="DISPLAY" \
	--add-host "${CONTAINER_HOSTNAME}:127.0.0.1" --hostname ${CONTAINER_HOSTNAME} \
	--device=/dev/ttyS0 --name ${CONTAINER_HOSTNAME} ${OWNER}/${IMAGE_NAME}
	
run-iws:
	@docker run --entrypoint /ros_aria_iws.sh -ti --rm --privileged \
	--network="host" --env="DISPLAY" \
	--add-host "${CONTAINER_HOSTNAME}:127.0.0.1" --hostname ${CONTAINER_HOSTNAME} \
	--device=/dev/ttyS0 --name ${CONTAINER_HOSTNAME} ${OWNER}/${IMAGE_NAME}

run-dev:
	docker run --entrypoint /bin/bash -ti --rm --privileged \
	-v ./p3dx/tmp/p3dx/src:/home/robot/projects/p3dx/src \
	--network="host" --env="DISPLAY" \
	--add-host "${CONTAINER_HOSTNAME}:127.0.0.1" --add-host "r0:10.76.11.50" --hostname ${CONTAINER_HOSTNAME} \
	--device=/dev/ttyS0 --name ${CONTAINER_HOSTNAME} ${OWNER}/${IMAGE_NAME}
	
attach:
	docker container exec -it ${CONTAINER_NAME} bash
	
p3dx/tmp/p3dx/src/rosaria:
	git clone -b devel   git@github.com:tuw-robotics/rosaria.git $@
	
p3dx/tmp/p3dx/src/tuw_p3dx:
	git clone -b master git@github.com:tuw-robotics/tuw_p3dx.git $@

p3dx/tmp/p3dx/src/tuw_teleop:
	git clone -b master git@github.com:tuw-robotics/tuw_teleop.git $@
	
p3dx/tmp/p3dx/src/tuw_msgs:
	git clone -b master git@github.com:tuw-robotics/tuw_msgs.git $@
	
p3dx/tmp/p3dx/src/tuw_geometry:
	git clone -b noetic git@github.com:tuw-robotics/tuw_geometry.git $@
	
p3dx/tmp/p3dx/src/tuw_launches:
	git clone -b noetic git@github.com:tuw-robotics/tuw_launches.git $@
	
p3dx/tmp/p3dx/src/tuw_gazebo:
	git clone -b noetic-devel git@github.com:tuw-robotics/tuw_gazebo.git $@
	
repo-clone: \
	p3dx/tmp/p3dx/src/rosaria \
	p3dx/tmp/p3dx/src/tuw_p3dx \
	p3dx/tmp/p3dx/src/tuw_msgs  \
	p3dx/tmp/p3dx/src/tuw_geometry \
	p3dx/tmp/p3dx/src/tuw_launches  \
	p3dx/tmp/p3dx/src/tuw_gazebo  \
	p3dx/tmp/p3dx/src/tuw_teleop 

repo-pull:
	find . -type d -name .git -exec echo {} \; -exec git --git-dir={} --work-tree=${PROJECT_DIR}/{}/.. pull origin \;
