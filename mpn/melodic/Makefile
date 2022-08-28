ROS_DISTRO = melodic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/bionic
ROOT_CONTAINER = ${OWNER}/${ROS_DISTRO}-desktop

RUN = mpn-desktop

all: help

help:
	@echo ""
	@echo "-- Help Menu for multi robot route planner (mpn)"
	@echo ""
	@echo "   global options with defaults:"
	@echo "     ROS_DISTRO=bionic"
	@echo "     OWNER=registry.auto.tuwien.ac.at/roblab/docker/bionic"
	@echo "     ROOT_CONTAINER=$$\$${OWNER}/bionic-ide"
	@echo "     RUN=mpn-desktop"
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
	@docker build -f Dockerfile-mpn -t ${OWNER}/${ROS_DISTRO}-mpn-desktop --build-arg ROOT_CONTAINER=${OWNER}/${ROS_DISTRO}-enviroment-desktop   .

push:
	@docker push ${OWNER}/${ROS_DISTRO}-mpn-desktop 
	
pull:
	@docker pull ${OWNER}/${ROS_DISTRO}-mpn-desktop 

clean:
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-mpn-desktop 

run:
	@echo ${OWNER}/${ROS_DISTRO}-${RUN}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${RUN}:127.0.0.1" -v ~/.ssh:/home/robot/.ssh:ro --name ${RUN} ${OWNER}/${ROS_DISTRO}-${RUN}
	
