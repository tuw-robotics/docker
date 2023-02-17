ROS_DISTRO = noetic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/focal
ROOT_CONTAINER = ${OWNER}/${ROS_DISTRO}-enviroment-core

RUN = p3dx-core
SSH_PRIVATE_KEY=`cat ~/.ssh/docker/id_rsa`
PROJECT_DIR = $(shell pwd)

all: help

help:
	@echo ""
	@echo "-- Help Menu for ROS ${ROS_DISTRO} based on $$\$${ROOT_CONTAINER}"
	@echo ""
	@echo "   global options with defaults:"
	@echo "     ROS_DISTRO=noetic"
	@echo "     OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal"
	@echo "     ROOT_CONTAINER=$$\$${OWNER}/noetic-core"
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
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-p3dx-core  --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}   --build-arg SSH_PRIVATE_KEY="${SSH_PRIVATE_KEY}" p3dx/.
	
push:
	@docker push ${OWNER}/${ROS_DISTRO}-p3dx-core
	
pull:
	@docker pull ${OWNER}/${ROS_DISTRO}-p3dx-core

clean:
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-p3dx-core

run-twist:
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${RUN}:127.0.0.1"  --device=/dev/ttyS0 --name ${RUN} ${OWNER}/${ROS_DISTRO}-${RUN}
	
run-iws:
	@docker run --entrypoint /ros_aria_iws.sh -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${RUN}:127.0.0.1"  --device=/dev/ttyS0 --name ${RUN} ${OWNER}/${ROS_DISTRO}-${RUN}

run-bash:
	@docker run --entrypoint /bin/bash -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${RUN}:127.0.0.1"  --device=/dev/ttyS0 --name ${RUN} ${OWNER}/${ROS_DISTRO}-${RUN}
	
attach:
	docker container exec -it ${RUN} bash
	
p3dx/tmp/p3dx/src/rosaria:
	git clone -b master   git@github.com:tuw-robotics/rosaria.git $@
	
p3dx/tmp/p3dx/src/tuw_p3dx:
	git clone -b devel git@github.com:tuw-robotics/tuw_p3dx.git $@

p3dx/tmp/p3dx/src/tuw_teleop:
	git clone -b master git@github.com:tuw-robotics/tuw_teleop.git $@
	
p3dx/tmp/p3dx/src/tuw_msgs:
	git clone -b master git@github.com:tuw-robotics/tuw_msgs.git $@
	
repo-clone: \
	p3dx/tmp/p3dx/src/rosaria \
	p3dx/tmp/p3dx/src/tuw_p3dx \
	p3dx/tmp/p3dx/src/tuw_msgs  \
	p3dx/tmp/p3dx/src/tuw_teleop 

repo-pull:
	find . -type d -name .git -exec echo {} \; -exec git --git-dir={} --work-tree=${PROJECT_DIR}/{}/.. pull origin \;
