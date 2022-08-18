ROOT_CONTAINER = ubuntu:focal
OWNER = registry.auto.tuwien.ac.at/roblab/docker/focal

all: help

help:
	@echo ""
	@echo "-- Help Menu"
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
	@docker build -t $(OWNER)/noetic-core             --build-arg ROOT_CONTAINER=$(ROOT_CONTAINER)   core/.
	@docker build -t $(OWNER)/noetic-base             --build-arg OWNER=$(OWNER)                     base/.
	@docker build -t $(OWNER)/noetic-robot            --build-arg OWNER=$(OWNER)                     robot/.
	# @docker build -t $(OWNER)/noetic-perception       --build-arg OWNER=$(OWNER)                     perception/.
	# @docker build -t $(OWNER)/noetic-desktop          --build-arg OWNER=$(OWNER)                     desktop/.
	# @docker build -t $(OWNER)/noetic-desktop-full     --build-arg OWNER=$(OWNER)                     desktop-full/.

push:
	@docker push $(OWNER)/noetic-core
	@docker push $(OWNER)/noetic-base
	@docker push $(OWNER)/noetic-robot
	# @docker pull $(OWNER)/noetic-perception
	# @docker pull $(OWNER)/noetic-desktop
	# @docker pull $(OWNER)/noetic-desktop-full
	
pull:
	@docker pull $(OWNER)/noetic-core
	@docker pull $(OWNER)/noetic-base
	@docker pull $(OWNER)/noetic-robot
	# @docker pull $(OWNER)/noetic-perception
	# @docker pull $(OWNER)/noetic-desktop
	# @docker pull $(OWNER)/noetic-desktop-full

clean:
	@docker rmi -f $(OWNER)/noetic-core
	@docker rmi -f $(OWNER)/noetic-base
	@docker rmi -f $(OWNER)/noetic-robot
	# @docker rmi -f $(OWNER)/noetic-perception
	# @docker rmi -f $(OWNER)/noetic-desktop
	# @docker rmi -f $(OWNER)/noetic-desktop-full
