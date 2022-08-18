ROS_DISTRO = noetic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/focal/$(ROS_DISTRO)
ROOT_CONTAINER = $(OWNER)/noetic-desktop

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
	@docker build -t $(OWNER)/$(ROS_DISTRO)/enviroment-core             --build-arg ROOT_CONTAINER=$(ROOT_CONTAINER)   core/.
	@docker build -t $(OWNER)/$(ROS_DISTRO)/enviroment-ide              --build-arg OWNER=$(OWNER)                     ide/.

push:
	@docker push $(OWNER)/$(ROS_DISTRO)/enviroment-core
	@docker push $(OWNER)/$(ROS_DISTRO)/enviroment-base
	
pull:
	@docker pull $(OWNER)/$(ROS_DISTRO)/enviroment-core
	@docker pull $(OWNER)/$(ROS_DISTRO)/enviroment-base
	@docker pull $(OWNER)/$(ROS_DISTRO)-desktop-full

clean:
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)/enviroment-core
	@docker rmi -f $(OWNER)/$(ROS_DISTRO)/enviroment-base
