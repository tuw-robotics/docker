ROS_DISTRO = noetic
OWNER = tuwrobotics
PREFIX = tuw
ROOT_CONTAINER = ${OWNER}/${PREFIX}-${ROS_DISTRO}-ide

PROJECT = pathfollowing
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
	@docker build --rm -t ${OWNER}/${IMAGE_NAME}  --build-arg ROOT_CONTAINER=${ROOT_CONTAINER} .
	
push:
	@docker push ${OWNER}/${IMAGE_NAME}
	
pull:
	@docker pull ${OWNER}/${IMAGE_NAME}

clean:
	@docker rmi -f ${OWNER}/${IMAGE_NAME}

run:
	@docker run -ti --rm --privileged \
	--network="host" --env="DISPLAY" \
	--add-host "${CONTAINER_HOSTNAME}:127.0.0.1" --hostname ${CONTAINER_HOSTNAME} \
	--device=/dev/ttyS0 --name ${CONTAINER_HOSTNAME} ${OWNER}/${IMAGE_NAME}
	
attach:
	docker container exec -it ${CONTAINER_HOSTNAME} bash
	
tmp/ws/src/tuw_msgs:
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_msgs.git $@

tmp/ws/src/tuw_geometry:
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_geometry.git $@

tmp/ws/src/tuw_control:
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_control.git $@
	
tmp/ws/src/tuw_gazebo:
	git clone -b noetic-devel           git@github.com:tuw-robotics/tuw_gazebo.git $@
	
tmp/ws/src/tuw_multi_robot:
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_multi_robot.git $@

tmp/ws/src/tuw_rviz:
	git clone --branch master           git@github.com:tuw-robotics/tuw_rviz.git $@
	rm $@/tuw_control_rviz/CATKIN_IGNORE

tmp/ws/src/tuw_diffdrive:
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_diffdrive.git $@

tmp/ws/src/tuw_global_planner:
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_global_planner.git $@

tmp/ws/src/tuw_launches:
	git clone --branch master           git@github.com:tuw-robotics/tuw_launches.git $@

tmp/ws/src/rosaria:
	git clone -b devel                  git@github.com:tuw-robotics/rosaria.git $@
	
repo-clone: \
	tmp/ws/src/rosaria \
	tmp/ws/src/tuw_msgs \
	tmp/ws/src/tuw_geometry \
	tmp/ws/src/tuw_gazebo \
	tmp/ws/src/tuw_control \
	tmp/ws/src/tuw_multi_robot  \
	tmp/ws/src/tuw_rviz \
	tmp/ws/src/tuw_diffdrive \
	tmp/ws/src/tuw_global_planner \
	tmp/ws/src/tuw_launches

repo-pull:
	find . -type d -name .git -exec echo {} \; -exec git --git-dir={} --work-tree=${PROJECT_DIR}/{}/.. pull origin \;
