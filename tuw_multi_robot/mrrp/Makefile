ROS_DISTRO = noetic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/focal
ROOT_CONTAINER = ${OWNER}/${ROS_DISTRO}-gui

RUN = mrrp-gui

all: help

help:
	@echo ""
	@echo "-- Help Menu for multi robot route planner (MRRP)"
	@echo ""
	@echo "   global options with defaults:"
	@echo "     ROS_DISTRO=noetic"
	@echo "     OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal"
	@echo "     ROOT_CONTAINER=$$\$${OWNER}/noetic-ide"
	@echo "     RUN=mrrp-gui"
	@echo ""
	@echo "   make build              - build all images"
	@echo "   make login USER=mbader  - authenticate container Registry"
	@echo "   make pull               - pull all images"
	@echo "   make push               - push all images"
	@echo "   make clean              - remove all images"
	@echo "   make run                - runs the image: $$\$${OWNER}/$$\$${ROS_DISTRO}/$$\$${RUN}"
	
	@echo ""

login:
	@docker login registry.auto.tuwien.ac.at -u ${USER}
	
build:
	@docker build -f Dockerfile-mrrp -t ${OWNER}/${ROS_DISTRO}-mrrp-gui             --build-arg ROOT_CONTAINER=${OWNER}/${ROS_DISTRO}-enviroment-ide   .

push:
	@docker push ${OWNER}/${ROS_DISTRO}-mrrp-gui 
	
pull:
	@docker pull ${OWNER}/${ROS_DISTRO}-mrrp-gui 

clean:
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-mrrp-gui 

run:
	@echo ${OWNER}/${ROS_DISTRO}-${RUN}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${RUN}:127.0.0.1" --name ${RUN} ${OWNER}/${ROS_DISTRO}-${RUN}
	
