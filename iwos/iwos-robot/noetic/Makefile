ROS_DISTRO = noetic
ROOT_CONTAINER_OWNER = tuwrobotics
ROOT_CONTAINER = ${ROOT_CONTAINER_OWNER}/tuw-${ROS_DISTRO}-ide
THIS_CONTAINER_OWNER = ekrobotics
THIS_CONTAINER = ${THIS_CONTAINER_OWNER}/tuw-${ROS_DISTRO}-iwos-robot
THIS_RUN = tuw-${ROS_DISTRO}-iwos-robot

PROJECT_DIR = $(shell pwd)

#SSH_PRIVATE_KEY=`cat ~/.ssh/docker/id_rsa`

all: help

help:
	@echo ""
	@echo "-- Help Menu for ROS ${ROS_DISTRO} based on $$\$${ROOT_CONTAINER}"
	@echo ""
	@echo "   global options with defaults:"
	@echo "     ROS_DISTRO=${ROS_DISTRO}"
	@echo "     ROOT_CONTAINER_OWNER=${ROOT_CONTAINER_OWNER}"
	@echo "     ROOT_CONTAINER=${ROOT_CONTAINER}"
	@echo "     THIS_CONTAINER_OWNER=${THIS_CONTAINER_OWNER}"
	@echo "     THIS_CONTAINER=${THIS_CONTAINER}"
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
	@docker login -u ${THIS_CONTAINER_OWNER}

build:
	@docker build --rm -t ${THIS_CONTAINER} --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}  --build-arg SSH_PRIVATE_KEY="${SSH_PRIVATE_KEY}" .

build_no_cache:
	@docker build --rm -t ${THIS_CONTAINER} --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}  --build-arg SSH_PRIVATE_KEY="${SSH_PRIVATE_KEY}" . --no-cache

git_pull:
	find . -type d -name .git -exec echo -n '{} - ' \; -exec git --git-dir=${PROJECT_DIR}/{} branch --show-current \; -exec git --git-dir=${PROJECT_DIR}/{} pull origin \;

docker_push:
	@docker push ${THIS_CONTAINER}

docker_pull:
	@docker pull ${THIS_CONTAINER}

echo_docker_pull:
	@echo "docker pull ${THIS_CONTAINER}"

clean:
	@docker rmi -f ${THIS_CONTAINER}

run:
	@docker run -ti --rm --network="host" --env="DISPLAY" --name ${THIS_RUN} --device=/dev/dynamixel --device=/dev/transducer --device=/dev/ttyACM0 --device=/dev/ttyACM1 --device=/dev/input/js0 ${THIS_CONTAINER}

echo_run:
	@echo "docker run -ti --rm --network="host" --env="DISPLAY" --name ${THIS_RUN} --device=/dev/dynamixel --device=/dev/transducer --device=/dev/ttyACM0 --device=/dev/ttyACM1 --device=/dev/input/js0 ${THIS_CONTAINER}"
