ROS_DISTRO = melodic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/bionic
ROOT_CONTAINER = ${OWNER}/${ROS_DISTRO}-desktop

RUN = enviroment-desktop

all: help

help:
	@echo ""
	@echo "-- Help Menu for ROS ${ROS_DISTRO} based on $$\$${ROOT_CONTAINER}"
	@echo ""
	@echo "   global options with defaults:"
	@echo "     ROS_DISTRO=melodic"
	@echo "     OWNER=registry.auto.tuwien.ac.at/roblab/docker/bionic"
	@echo "     ROOT_CONTAINER=$$\$${OWNER}/melodic-desktop"
	@echo "     RUN=enviroment-desktop"
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
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-core             --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}   core/.
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-desktop          --build-arg OWNER=${OWNER}/${ROS_DISTRO}       desktop/.
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-ide              --build-arg OWNER=${OWNER}/${ROS_DISTRO}       ide/.

push:
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-desktop
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-ide
	
pull:
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-base
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-ide

clean:
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-base
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-ide

run:
	@echo ${OWNER}/${ROS_DISTRO}-${RUN}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${RUN}:127.0.0.1" --name ${RUN} ${OWNER}/${ROS_DISTRO}-${RUN}
	
