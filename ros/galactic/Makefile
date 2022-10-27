ROOT_CONTAINER = ubuntu:focal
OWNER = registry.auto.tuwien.ac.at/roblab/docker/focal
ROS_DISTRO = galactic

all: help

help:
	@echo ""
	@echo "-- Help Menu for ROS $(ROS_DISTRO) based on $(ROOT_CONTAINER)"
	@echo ""
	@echo "   make build              - build all images"
	@echo "   make login USER=mbader  - authenticate container Registry"
	@echo "   make pull               - pull all images"
	@echo "   make push               - push all images"
	@echo "   make clean              - remove all images"
	@echo ""

login:
	@docker login registry.auto.tuwien.ac.at -u $(USER)
	
build-core:
	docker build --rm -t  $(OWNER)/$(ROS_DISTRO)-core             --build-arg ROOT_CONTAINER=$(ROOT_CONTAINER)   ubuntu/focal/core/.
	
build-base: build-core
	docker build --rm -t  $(OWNER)/$(ROS_DISTRO)-base             --build-arg OWNER=$(OWNER)                     ubuntu/focal/base/.
	
build-desktop: build-base
	docker build --rm -t  $(OWNER)/$(ROS_DISTRO)-desktop          --build-arg OWNER=$(OWNER)                     ubuntu/focal/desktop/.

build-bridge: build-base
	docker build --rm -t  $(OWNER)/$(ROS_DISTRO)-bridge           --build-arg OWNER=$(OWNER)                     ubuntu/focal/bridge/.

build-tuw-bridge: build-base
	docker build --rm -t  $(OWNER)/$(ROS_DISTRO)-tuw-bridge       --build-arg OWNER=$(OWNER)                     ubuntu/focal/tuw-bridge/.

build: build-core build-base build-desktop build-bridge build-tuw-bridge
 
push:
	@docker push $(OWNER)/$(ROS_DISTRO)-core
	@docker push $(OWNER)/$(ROS_DISTRO)-base
	@docker push $(OWNER)/$(ROS_DISTRO)-bridge
	@docker push $(OWNER)/$(ROS_DISTRO)-desktop
	
pull:
	@docker pull $(OWNER)/$(ROS_DISTRO)-core
	@docker pull $(OWNER)/$(ROS_DISTRO)-base
	@docker pull $(OWNER)/$(ROS_DISTRO)-bridge
	@docker pull $(OWNER)/$(ROS_DISTRO)-desktop

clean:
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-core
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-base
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-bridge
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-desktop
