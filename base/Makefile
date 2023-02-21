OWNER = tuwrobotics
PREFIX = tuw

PROJECT_DIR = $(shell cd ..; pwd)
HOSTNAME := $(shell hostname)
TAG = latest 
ROS_DISTRO = NA
	
all: help

help:
	@echo ""
	@echo "   Help Menu"
	@echo ""
	@echo "   make build                                   - build all images"
	@echo "   build-humble                                 - build our humbe  (ROS2) container"
	@echo "   build-noetic                                 - build our noetic (ROS1) container"
	@echo "   make login USER=username                     - authenticate container Registry"
	@echo "   make pull ROS_DISTRO={humble,noetic,melodic} - pull all images exept develop"
	@echo "   make push ROS_DISTRO={humble,noetic}         - push all images exept develop"
	@echo "   make run ROS_DISTRO={humble,noetic}          - runs
	@echo ""

login:
	@docker login -u ${USER} 

pull:
	@docker pull ${OWNER}/${PREFIX}-${ROS_DISTRO}-base

push:
	@docker push ${OWNER}/${PREFIX}-${ROS_DISTRO}-base
		
push-taged: guard-NEW_TAG
	@docker tag ${OWNER}/${PREFIX}-${ROS_DISTRO}-base ${OWNER}/${PREFIX}-${ROS_DISTRO}-base:${NEW_TAG}
	@docker push ${OWNER}/${PREFIX}-${ROS_DISTRO}-base:${NEW_TAG}
	
build: build-humble build-noetic

build-humble: 
	@docker build --rm -t ${OWNER}/${PREFIX}-humble-base \
															--build-arg ROS_DISTRO=humble \
															--build-arg OWNER=osrf \
															--build-arg BASE_CONTAINER=ros:humble-desktop \
													        --build-arg INSTALL_TERMINAL_TOOLS=true \
													        --build-arg INSTALL_STAGE=true \
													        --build-arg INSTALL_XFCE=true \
													        --build-arg INSTALL_VSCODE=true \
													        --build-arg INSTALL_GAZEBO=true \
													        --build-arg INSTALL_VNC=true \
															--build-arg INSTALL_ROS_TOOLS=true \
															--build-arg INSTALL_ROS1_TOOLS=false \
															--build-arg INSTALL_ROS2_TOOLS=true \
															--build-arg INSTALL_ROS_BRIDGE=false \
															-f ./Dockerfile-base .
	
build-noetic: 
	@docker build --rm -t ${OWNER}/${PREFIX}-noetic-base \
															--build-arg ROS_DISTRO=noetic \
															--build-arg OWNER=osrf \
															--build-arg BASE_CONTAINER=ros:noetic-desktop \
													        --build-arg INSTALL_TERMINAL_TOOLS=true \
													        --build-arg INSTALL_STAGE=true \
													        --build-arg INSTALL_XFCE=true \
													        --build-arg INSTALL_VSCODE=true \
													        --build-arg INSTALL_GAZEBO=true \
													        --build-arg INSTALL_VNC=true \
															--build-arg INSTALL_ROS_TOOLS=true \
															--build-arg INSTALL_ROS1_TOOLS=true \
															--build-arg INSTALL_ROS2_TOOLS=false \
															--build-arg INSTALL_ROS_BRIDGE=true \
															-f ./Dockerfile-base .

build-melodic: 
	@docker build --rm -t ${OWNER}/${PREFIX}-melodic-base \
															--build-arg ROS_DISTRO=melodic \
															--build-arg OWNER=osrf \
															--build-arg BASE_CONTAINER=ros:melodic-desktop \
													        --build-arg INSTALL_TERMINAL_TOOLS=true \
													        --build-arg INSTALL_STAGE=true \
													        --build-arg INSTALL_XFCE=true \
													        --build-arg INSTALL_VSCODE=false \
													        --build-arg INSTALL_GAZEBO=false \
													        --build-arg INSTALL_VNC=false \
															--build-arg INSTALL_ROS_TOOLS=true \
															--build-arg INSTALL_ROS1_TOOLS=true \
															--build-arg INSTALL_ROS2_TOOLS=false \
															--build-arg INSTALL_ROS_BRIDGE=false \
															-f ./Dockerfile-base .
	

run:
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged --network="host" --env="DISPLAY" \
	    --add-host "${HOSTNAME}-${ROS_DISTRO}:127.0.0.1" \
	    --hostname ${HOSTNAME}-${ROS_DISTRO} \
	    --name ${HOSTNAME}-${ROS_DISTRO} \
		-v /dev/shm:/dev/shm \
		${OWNER}/${PREFIX}-${ROS_DISTRO}-base

