ROOT_CONTAINER = ubuntu:jammy
OWNER = registry.auto.tuwien.ac.at/roblab/docker/jammy
ROS_DISTRO = humble

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
	
build:
	@docker build --rm -t $(OWNER)/$(ROS_DISTRO)-core             --build-arg ROOT_CONTAINER=$(ROOT_CONTAINER)   ubuntu/jammy/core/.
	@docker build --rm -t $(OWNER)/$(ROS_DISTRO)-base             --build-arg OWNER=$(OWNER)                     ubuntu/jammy/base/.
	@docker build --rm -t $(OWNER)/$(ROS_DISTRO)-desktop          --build-arg OWNER=$(OWNER)                     ubuntu/jammy/desktop/.

push:
	@docker push $(OWNER)/$(ROS_DISTRO)-core
	@docker push $(OWNER)/$(ROS_DISTRO)-base
	@docker push $(OWNER)/$(ROS_DISTRO)-desktop
	
pull:
	@docker pull $(OWNER)/$(ROS_DISTRO)-core
	@docker pull $(OWNER)/$(ROS_DISTRO)-base
	@docker pull $(OWNER)/$(ROS_DISTRO)-desktop

clean:
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-core
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-base
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-desktop
