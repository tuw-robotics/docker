ROS_DISTRO = melodic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/bionic
ROOT_CONTAINER = ${OWNER}/${ROS_DISTRO}-desktop

RUN = mpn
SSH_PRIVATE_KEY=`cat ~/.ssh/docker/id_rsa`

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
	@docker build  --rm -t ${OWNER}/${ROS_DISTRO}-mpn                --build-arg ROOT_CONTAINER=${OWNER}/${ROS_DISTRO}-enviroment-desktop   --build-arg SSH_PRIVATE_KEY="${SSH_PRIVATE_KEY}" core/.

push:
	@docker push ${OWNER}/${ROS_DISTRO}-mpn
	
pull:
	@docker pull ${OWNER}/${ROS_DISTRO}-mpn

clean:
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-mpn

run:
	@echo ${OWNER}/${ROS_DISTRO}-${RUN}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${RUN}:127.0.0.1" -v ~/.ssh:/home/robot/.ssh:ro --name ${RUN} ${OWNER}/${ROS_DISTRO}-${RUN}

