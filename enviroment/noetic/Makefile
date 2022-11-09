ROS_DISTRO = noetic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/focal
ROOT_CONTAINER = ${OWNER}/${ROS_DISTRO}-desktop
PRJ_DIR = ${HOME}/projects

RUN = enviroment-desktop
PERSISTENT_IDE = ${HOME}/tmp/${OWNER}/${ROS_DISTRO}-enviroment-ide
PERSISTENT_GZ  = ${HOME}/tmp/${OWNER}/${ROS_DISTRO}-enviroment-gazebo
HOSTNAME := $(shell hostname)
	

all: help

help:
	@echo ""
	@echo "-- Help Menu for ROS ${ROS_DISTRO} based on $$\$${ROOT_CONTAINER}"
	@echo ""
	@echo "   global options with defaults:"
	@echo "     ROS_DISTRO=noetic"
	@echo "     OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal"
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

build-core:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-core             --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}   core/.
	
build-desktop:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-desktop          --build-arg OWNER=${OWNER}/${ROS_DISTRO}       desktop/.
	
build-ide:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-ide              --build-arg OWNER=${OWNER}/${ROS_DISTRO}       ide/.
	
build-gazebo:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-gazebo           --build-arg OWNER=${OWNER}/${ROS_DISTRO}       -f gazebo/Dockerfile-gazebo    gazebo/.
	
login:
	@docker login registry.auto.tuwien.ac.at -u ${USER}
	
build: build-core build-desktop build-ide build-gazebo

push:
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-desktop
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-ide
	
pull:
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-desktop
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-ide

clean:
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-desktop
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-ide

run:
	@echo ${OWNER}/${ROS_DISTRO}-${RUN}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${RUN}:127.0.0.1" --name ${RUN} ${OWNER}/${ROS_DISTRO}-${RUN}

${PERSISTENT_GZ}:
	@echo create PERSISTENT_GZ folder: ${PERSISTENT_GZ}
	@mkdir -p ${PERSISTENT_GZ}/home \
	          ${PERSISTENT_GZ}/runtime-robot
	@chmod 0700 -R ${PERSISTENT_GZ}/runtime-robot
	@echo "Run the following command in your container"
	@echo " rsync -av /home/robot /tmp/home; exit"
	@docker run --rm -ti -v ${PERSISTENT_GZ}/home:/tmp/home ${OWNER}/${ROS_DISTRO}-enviroment-gazebo
	
# runs the gazebo container
run-gz: ${PERSISTENT_GZ}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${HOSTNAME}-gazebo:127.0.0.1" --hostname ${HOSTNAME}-gazebo --name ${HOSTNAME}-gazebo \
		-v ${HOME}/.sdformat:/home/robot/.sdformat \
		-v ${HOME}/.ignition:/home/robot/.ignition \
		-v ${HOME}/.gazebo:/home/robot/.gazebo \
		-v ${PERSISTENT_GZ}/runtime-robot:/tmp/runtime-robot \
		-v /dev/shm:/dev/shm \
	${OWNER}/${ROS_DISTRO}-enviroment-gazebo	
	
run-gz-dev: ${PERSISTENT_GZ}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${HOSTNAME}-gazebo:127.0.0.1" --hostname ${HOSTNAME}-gazebo --name ${HOSTNAME}-gazebo \
		-v ${PERSISTENT_GZ}/home:/home \
		-v ${HOME}/.gitconfig:/home/robot/.gitconfig:ro \
		-v ${HOME}/.ssh:/home/robot/.ssh:ro \
		-v ${PERSISTENT_GZ}/runtime-robot:/tmp/runtime-robot \
		-v ${PRJ_DIR}:/home/robot/projects \
		-v /dev/shm:/dev/shm \
	${OWNER}/${ROS_DISTRO}-enviroment-gazebo

repo-rm:
	rm -rf gazebo/tmp/*
	
repo-clone:
	git clone --branch noetic-devel     git@github.com:ros-simulation/gazebo_ros_pkgs.git    gazebo/tmp/ws00/src/gazebo_ros_pkgs
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_msgs.git             gazebo/tmp/ws00/src/tuw_msgs
	git clone --branch noetic-devel     git@github.com:tuw-robotics/tuw_gazebo.git           gazebo/tmp/ws01/src/tuw_gazebo
	git clone --branch master           git@github.com:tuw-robotics/tuw_launches.git         gazebo/tmp/ws01/src/tuw_launches


repo-update:
	find ./gazebo/tmp -name .git -exec git --git-dir={} pull \;
