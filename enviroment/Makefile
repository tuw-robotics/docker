ROS_DISTRO = noetic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/focal/${ROS_DISTRO}
ROOT_CONTAINER = ${OWNER}/noetic-desktop

RUN = enviroment-desktop

all: help

help:
	@echo ""
	@echo "-- Help Menu for ROS ${ROS_DISTRO} based on $$\$${ROOT_CONTAINER}"
	@echo ""
	@echo "   global options with defaults:"
	@echo "     ROS_DISTRO=noetic"
	@echo "     OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal/$$\$${ROS_DISTRO}"
	@echo "     ROOT_CONTAINER=$$\$${OWNER}/noetic-desktop"
	@echo "     RUN=enviroment-core"
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
	@docker build -t ${OWNER}/${ROS_DISTRO}/enviroment-core             --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}   core/.
	@docker build -t ${OWNER}/${ROS_DISTRO}/enviroment-desktop          --build-arg OWNER=${OWNER}                     desktop/.

push:
	@docker push ${OWNER}/${ROS_DISTRO}/enviroment-core
	@docker push ${OWNER}/${ROS_DISTRO}/enviroment-base
	
pull:
	@docker pull ${OWNER}/${ROS_DISTRO}/enviroment-core
	@docker pull ${OWNER}/${ROS_DISTRO}/enviroment-base
	@docker pull ${OWNER}/${ROS_DISTRO}-desktop-full

clean:
	@docker rmi -f ${OWNER}/${ROS_DISTRO}/enviroment-core
	@docker rmi -f ${OWNER}/${ROS_DISTRO}/enviroment-base

run:
	@echo ${OWNER}/${ROS_DISTRO}/${RUN}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${RUN}:127.0.0.1" --name ${RUN} ${OWNER}/${ROS_DISTRO}/${RUN}
	
