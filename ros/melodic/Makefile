ROOT_CONTAINER = ubuntu:bionic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/bionic
ROS_DISTRO = melodic

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
	@docker build --rm  --squash -t $(OWNER)/$(ROS_DISTRO)-core             --build-arg ROOT_CONTAINER=$(ROOT_CONTAINER)   ubuntu/bionic/core/.
	@docker build --rm  --squash -t $(OWNER)/$(ROS_DISTRO)-base             --build-arg OWNER=$(OWNER)                     ubuntu/bionic/base/.
	@docker build --rm  --squash -t $(OWNER)/$(ROS_DISTRO)-robot            --build-arg OWNER=$(OWNER)                     ubuntu/bionic/robot/.
	@docker build --rm  --squash -t $(OWNER)/$(ROS_DISTRO)-perception       --build-arg OWNER=$(OWNER)                     ubuntu/bionic/perception/.
	@docker build --rm  --squash -t $(OWNER)/$(ROS_DISTRO)-desktop          --build-arg OWNER=$(OWNER)                     ubuntu/bionic/desktop/.
	@docker build --rm  --squash -t $(OWNER)/$(ROS_DISTRO)-desktop-full     --build-arg OWNER=$(OWNER)                     ubuntu/bionic/desktop-full/.

push:
	@docker push $(OWNER)/$(ROS_DISTRO)-core
	@docker push $(OWNER)/$(ROS_DISTRO)-base
	@docker push $(OWNER)/$(ROS_DISTRO)-robot
	@docker push $(OWNER)/$(ROS_DISTRO)-perception
	@docker push $(OWNER)/$(ROS_DISTRO)-desktop
	@docker push $(OWNER)/$(ROS_DISTRO)-desktop-full
	
pull:
	@docker pull $(OWNER)/$(ROS_DISTRO)-core
	@docker pull $(OWNER)/$(ROS_DISTRO)-base
	@docker pull $(OWNER)/$(ROS_DISTRO)-robot
	@docker pull $(OWNER)/$(ROS_DISTRO)-perception
	@docker pull $(OWNER)/$(ROS_DISTRO)-desktop
	@docker pull $(OWNER)/$(ROS_DISTRO)-desktop-full

clean:
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-core
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-base
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-robot
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-perception
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-desktop
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)-desktop-full
