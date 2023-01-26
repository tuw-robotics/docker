ROS_DISTRO = noetic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/focal
ROOT_CONTAINER = ${OWNER}/${ROS_DISTRO}-enviroment-core
THIS_CONTAINER = ${OWNER}/${ROS_DISTRO}-iwos-robot
THIS_RUN = ${ROS_DISTRO}-iwos-robot

SSH_PRIVATE_KEY=`cat ~/.ssh/docker/id_rsa`

all: help

help:
	@echo ""
	@echo "-- Help Menu for ROS ${ROS_DISTRO} based on $$\$${ROOT_CONTAINER}"
	@echo ""
	@echo "   global options with defaults:"
	@echo "     ROS_DISTRO=${ROS_DISTRO}"
	@echo "     OWNER=${OWNER}"
	@echo "     ROOT_CONTAINER=${ROOT_CONTAINER}"
	@echo "     RUN=${RUN}"
	@echo ""
	@echo "   make login						- authenticate container Registry"
	@echo "   make build      			- build the image"
	@echo "   make build_no_cache		- build the image ()"
	@echo "   make pull       			- pull the image from the container registry"
	@echo "   make echo_pull       	- prints the command to pull the image"
	@echo "   make push       			- push the image to the container registry"
	@echo "   make clean      			- remove the image"
	@echo "   make run        			- runs the image"
	@echo ""

login:
	@docker login registry.auto.tuwien.ac.at -u ${ROBLAB_USER}

build:
	@docker build --rm -t ${THIS_CONTAINER} --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}  --build-arg SSH_PRIVATE_KEY="${SSH_PRIVATE_KEY}" core/.

build_no_cache:
	@docker build --rm -t ${THIS_CONTAINER} --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}  --build-arg SSH_PRIVATE_KEY="${SSH_PRIVATE_KEY}" core/. --no-cache

push:
	@docker push ${THIS_CONTAINER}

pull:
	@docker pull ${THIS_CONTAINER}

echo_pull:
	@echo "docker pull ${THIS_CONTAINER}"

clean:
	@docker rmi -f ${THIS_CONTAINER}

run:
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --name ${THIS_RUN} --device=/dev/ttyUSB0 --device=/dev/ttyACM0 --device=/dev/ttyACM1 --device=/dev/input/js0 ${THIS_CONTAINER}

echo_run:
	@echo "docker run -ti --rm --privileged --network="host" --env="DISPLAY" --name ${THIS_RUN} --device=/dev/ttyUSB0 --device=/dev/ttyACM0 --device=/dev/ttyACM1 --device=/dev/input/js0 ${THIS_CONTAINER}"
