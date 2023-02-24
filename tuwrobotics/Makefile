OWNER = tuwrobotics
PREFIX = tuw

PROJECT_DIR = $(shell cd ..; pwd)
HOSTNAME := $(shell hostname)
TAG = latest 
ROS_DISTRO = humble
	
all: help

help:
	@echo ""
	@echo "   Help Menu"
	@echo ""
	@echo "   make build                    - build all images"
	@echo "   build-humble                  - build our humbe  images"
	@echo "   build-noetic                  - build our noetic images"
	@echo "   build-melodic                 - build our noetic images"
	@echo "   make login USER=username      - login container registry"
	@echo "   make pull ROS_DISTRO={distro} - pull image"
	@echo "   make push ROS_DISTRO={distro} - push image"
	@echo "   make run ROS_DISTRO={distro}  - runs a image"
	@echo ""
	@echo "     distro={noetic, melodic,humble}"
	@echo "    	        default: humble"
	@echo ""

login:
	@docker login -u ${USER} 

pull: push-humble push-noetic push-melodic

push: push-humble push-noetic push-melodic
		
push-taged: guard-NEW_TAG
	@docker tag ${OWNER}/${PREFIX}-${ROS_DISTRO}-ide ${OWNER}/${PREFIX}-${ROS_DISTRO}-ide:${NEW_TAG}
	@docker push ${OWNER}/${PREFIX}-${ROS_DISTRO}-ide:${NEW_TAG}
	
build: build-humble build-noetic build-melodic

build-humble: 
	@docker build --rm -t ${OWNER}/${PREFIX}-humble-ide \
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
				-f ./Dockerfile .

push-humble:
	@docker push ${OWNER}/${PREFIX}-humble-ide
	
pull-humble:
	@docker pull ${OWNER}/${PREFIX}-humble-ide
	
build-noetic: 
	@docker build --rm -t ${OWNER}/${PREFIX}-noetic-ide \
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
				-f ./Dockerfile .
															
push-noetic:
	@docker push ${OWNER}/${PREFIX}-noetic-ide
	
pull-noetic:
	@docker pull ${OWNER}/${PREFIX}-noetic-ide

build-melodic: 
	@docker build --rm -t ${OWNER}/${PREFIX}-melodic-ide \
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
				-f ./Dockerfile .
															
															
push-melodic:
	@docker push ${OWNER}/${PREFIX}-melodic-ide
	
pull-melodic:
	@docker pull ${OWNER}/${PREFIX}-melodic-ide


run:
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged --network="host" --env="DISPLAY" \
	    --add-host "${HOSTNAME}-${ROS_DISTRO}:127.0.0.1" \
	    --hostname ${HOSTNAME}-${ROS_DISTRO} \
	    --name ${HOSTNAME}-${ROS_DISTRO} \
		-v /dev/shm:/dev/shm \
		${OWNER}/${PREFIX}-${ROS_DISTRO}-ide

