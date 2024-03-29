ROS_DISTRO = noetic
ROOT_CONTAINER_OWNER = tuwrobotics
ROOT_CONTAINER = ${ROOT_CONTAINER_OWNER}/tuw-${ROS_DISTRO}-ide
THIS_CONTAINER_OWNER = ${CONTAINER_OWNER}
THIS_CONTAINER = ${THIS_CONTAINER_OWNER}/tuw-${ROS_DISTRO}-iwos-robot
THIS_RUN = tuw-${ROS_DISTRO}-iwos-robot
HOST_USER = ${USER}

PROJECT_DIR = $(shell pwd)
DYNAMIXEL_PORT = $(shell readlink /dev/dynamixel)

all: help

help:
	@echo ""
	@echo "Help overview for ROS ${ROS_DISTRO} docker image based on ${ROOT_CONTAINER} docker image"
	@echo ""
	@echo "   global options with defaults:"
	@echo "     ROS_DISTRO=${ROS_DISTRO}"
	@echo "     ROOT_CONTAINER_OWNER=${ROOT_CONTAINER_OWNER}"
	@echo "     ROOT_CONTAINER=${ROOT_CONTAINER}"
	@echo "     THIS_CONTAINER_OWNER=${THIS_CONTAINER_OWNER}"
	@echo "     THIS_CONTAINER=${THIS_CONTAINER}"
	@echo ""
	@echo "   make docker_login         - authenticate container Registry"
	@echo "   make docker_push          - push the image to the container registry"
	@echo "   make docker_pull          - pull the image from the container registry"
	@echo "   make docker_print_pull    - print the command to pull the image"
	@echo "   make build                - build the image"
	@echo "   make build_no_cache       - build the image without cache"
	@echo "   make git_clone repo=\"<repo url>\" ws=\"<ws00 or ws01>\" branch=\"<branch name>\""
	@echo "                             - clone the branch from the repo into the source/ws folder"
	@echo "   make git_pull             - pull changes from all git repositories within the source folder"
	@echo "   make clean                - remove the image"
	@echo "   make run                  - run the image"
	@echo "   make print_run            - print the command to run the image"
	@echo ""

docker_login:
	@docker login -u ${THIS_CONTAINER_OWNER}

docker_push:
	@docker push ${THIS_CONTAINER}

docker_pull:
	@docker pull ${THIS_CONTAINER}

git_clone:
	@cd ./source/$(ws)/src && git clone --branch $(branch) $(repo) && cd ${PROJECT_DIR}

git_pull:
	@find . -type d -name .git -exec echo -n '{} - ' \; -exec git --git-dir=${PROJECT_DIR}/{} branch --show-current \; -exec git --git-dir={} --work-tree=${PROJECT_DIR}/{}/.. pull origin \;

docker_build:
	@docker build --rm -t ${THIS_CONTAINER} --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}  --build-arg SSH_PRIVATE_KEY="${SSH_PRIVATE_KEY}" .

docker_build_no_cache:
	@docker build --rm -t ${THIS_CONTAINER} --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}  --build-arg SSH_PRIVATE_KEY="${SSH_PRIVATE_KEY}" . --no-cache

docker_run:
	@docker run -ti --rm --name ${THIS_RUN} \
                       --network="host" \
                       --env="DISPLAY"  \
                       --privileged \
                       -e DYNAMIXEL_PORT=$(shell readlink /dev/dynamixel) \
                       --mount type=bind,source=/dev/dynamixel,target=/dev/dynamixel \
                       --mount type=bind,source=/dev/transducer,target=/dev/transducer \
                       ${THIS_CONTAINER}

clean:
	@docker rmi -f ${THIS_CONTAINER}

print_docker_pull:
	@echo docker pull ${THIS_CONTAINER}

readlink_function = "$$ \b(readlink /dev/dynamixel)"
print_docker_run:
	@echo docker run -ti --rm --name ${THIS_RUN} \
                            --network="host" \
                            --env="DISPLAY"  \
                            --privileged \
                            -e DYNAMIXEL_PORT=${readlink_function} \
                            --mount type=bind,source=/dev/dynamixel,target=/dev/dynamixel \
                            --mount type=bind,source=/dev/transducer,target=/dev/transducer \
                            ${THIS_CONTAINER}