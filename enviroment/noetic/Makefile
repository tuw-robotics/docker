ROS_DISTRO = noetic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/focal
ROOT_CONTAINER = ${OWNER}/${ROS_DISTRO}-desktop
PRJ_DIR = ${HOME}/projects

PERSISTENT_IDE = ${HOME}/tmp/${OWNER}/${ROS_DISTRO}-enviroment-ide
PERSISTENT_MR = ${HOME}/tmp/${OWNER}/${ROS_DISTRO}-enviroment-mobile-robotics
PERSISTENT_GZ  = ${HOME}/tmp/${OWNER}/${ROS_DISTRO}-enviroment-gazebo
HOSTNAME := $(shell hostname)
HOSTNAME_NAME=${HOSTNAME}
	

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
	@echo ""

build-core:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-core             --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}                -f core/Dockerfile-core core/.
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-bridge           --build-arg ROOT_CONTAINER=ros:galactic-ros1-bridge-focal   -f core/Dockerfile-bridge core/.
	
build-desktop:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-desktop          --build-arg OWNER=${OWNER}/${ROS_DISTRO}                    -f desktop/Dockerfile-desktop                desktop/.
	
build-ide:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-ide              --build-arg OWNER=${OWNER}/${ROS_DISTRO}                    -f ide/Dockerfile-ide                        ide/.
	
build-gazebo:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-gazebo           --build-arg OWNER=${OWNER}/${ROS_DISTRO}                    -f gazebo/Dockerfile-gazebo                  gazebo/.
	
build-bridge:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-bridge-stage     --build-arg OWNER=${OWNER}/${ROS_DISTRO}                    -f bridge/Dockerfile-stage                   bridge/.
	
build-mobile-robotics:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-mobile-robotics  --build-arg OWNER=${OWNER}/${ROS_DISTRO}                    -f mobile-robotics/Dockerfile-mr             mobile-robotics/.
	
build-pathfollowing:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-pathfollowing    --build-arg OWNER=${OWNER}/${ROS_DISTRO}                      -f pathfollowing/Dockerfile-pathfollowing    pathfollowing/.
		
login:
	@docker login registry.auto.tuwien.ac.at -u ${USER}
	
build: build-core build-desktop build-ide build-gazebo build-pathfollowing build-mobile-robotics

push:
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-bridge
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-desktop
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-ide
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-gazebo
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-pathfollowing
	
pull:
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-bridge
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-desktop
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-ide
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-gazebo
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-pathfollowing

clean:
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-bridge
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-desktop
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-ide
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-gazebo
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-pathfollowing

run-core:
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged --network="host" --add-host "${HOSTNAME_NAME}:127.0.0.1" --hostname ${HOSTNAME_NAME} --name ${HOSTNAME}-core \
	${OWNER}/${ROS_DISTRO}-enviroment-core

run-bridge:
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged --network="host" --add-host "${HOSTNAME_NAME}:127.0.0.1" --hostname ${HOSTNAME_NAME} --name ${HOSTNAME}-bridge \
	${OWNER}/${ROS_DISTRO}-enviroment-bridge
	
run-desktop:
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged --network="host" --add-host "${HOSTNAME_NAME}:127.0.0.1" --hostname ${HOSTNAME_NAME} --name ${HOSTNAME}-desktop \
	${OWNER}/${ROS_DISTRO}-enviroment-desktop
	
${PERSISTENT_IDE}:
	@mkdir -p ${PERSISTENT_IDE}/home ${PERSISTENT_IDE}/runtime-robot
	@chmod 0700 -R ${PERSISTENT_IDE}/runtime-robot
	@docker run --rm -ti --entrypoint='' -v ${PERSISTENT_IDE}/home:/tmp/home ${OWNER}/${ROS_DISTRO}-enviroment-ide rsync -a --delete /home/robot /tmp/home
	@echo "\e[1;46m\n Home folder for containter created under \n\n  ${PERSISTENT_GZ} \n\e[0m"

run-ide-clear:
	rm -rf ${PERSISTENT_IDE}
	
run-ide: ${PERSISTENT_IDE}
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged --network="host" --add-host "${HOSTNAME_NAME}:127.0.0.1" --hostname ${HOSTNAME_NAME} --name ${HOSTNAME}-ide \
	-v ${PERSISTENT_IDE}/home:/home \
	-v ${PRJ_DIR}:/home/robot/projects \
	-v ${PERSISTENT_IDE}/runtime-robot:/tmp/runtime-robot \
	${OWNER}/${ROS_DISTRO}-enviroment-ide	
	
${PERSISTENT_MR}:
	@mkdir -p ${PERSISTENT_MR}/home ${PERSISTENT_MR}/runtime-robot
	@chmod 0700 -R ${PERSISTENT_MR}/runtime-robot
	@docker run --rm -ti --entrypoint='' -v ${PERSISTENT_MR}/home:/tmp/home ${OWNER}/${ROS_DISTRO}-enviroment-mobile-robotics rsync -a --delete /home/robot /tmp/home
	@echo "\e[1;46m\n Home fold folder for containter created under \n\n  ${PERSISTENT_GZ} \n\e[0m"

run-mobile-robotics-clear:
	rm -rf ${PERSISTENT_MR}

run-mobile-robotics: ${PERSISTENT_MR}
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged --network="host" --env="DISPLAY" --add-host "${HOSTNAME_NAME}:127.0.0.1" --hostname ${HOSTNAME_NAME} --name ${HOSTNAME}-mr \
	-v ${PERSISTENT_MR}/home:/home \
	${OWNER}/${ROS_DISTRO}-enviroment-mobile-robotics
	
run-pathfollowing:
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged --network="host" --env="DISPLAY" --add-host "${HOSTNAME_NAME}:127.0.0.1" --hostname ${HOSTNAME_NAME} --name ${HOSTNAME}-pathfollowing \
	${OWNER}/${ROS_DISTRO}-enviroment-pathfollowing	
	
	
run-bridge-stage:
	@docker run -ti -e "TERM=xterm-256color" --rm --privileged --network="host" --env="DISPLAY" --add-host "${HOSTNAME_NAME}:127.0.0.1" --hostname ${HOSTNAME_NAME} --name ${HOSTNAME}-bridge-stage \
		-v /dev/shm:/dev/shm \
	${OWNER}/${ROS_DISTRO}-enviroment-bridge-stage	
	

${PERSISTENT_GZ}:
	@echo create PERSISTENT_GZ folder: ${PERSISTENT_GZ}
	@mkdir -p ${PERSISTENT_GZ}/home \
	          ${PERSISTENT_GZ}/runtime-robot
	@chmod 0700 -R ${PERSISTENT_GZ}/runtime-robot
	@echo "Run the following command in your container"
	@echo " rsync -av --delete /home/robot /tmp/home; exit"
	@docker run --rm -ti -v ${PERSISTENT_GZ}/home:/tmp/home ${OWNER}/${ROS_DISTRO}-enviroment-gazebo
	
# runs the gazebo container
run-gz: ${PERSISTENT_GZ}
	@docker run -ti  -e "TERM=xterm-256color" --rm --privileged --network="host" --env="DISPLAY" --add-host "${HOSTNAME_NAME}:127.0.0.1" --hostname ${HOSTNAME_NAME} --name ${HOSTNAME}-gazebo \
		-v ${HOME}/.sdformat:/home/robot/.sdformat \
		-v ${HOME}/.ignition:/home/robot/.ignition \
		-v ${HOME}/.gazebo:/home/robot/.gazebo \
		-v ${PERSISTENT_GZ}/runtime-robot:/tmp/runtime-robot \
		-v /dev/shm:/dev/shm \
	${OWNER}/${ROS_DISTRO}-enviroment-gazebo	
	
run-gz-dev: ${PERSISTENT_GZ}
	@docker run -ti  -e "TERM=xterm-256color" --rm --privileged --network="host" --env="DISPLAY" --add-host "${HOSTNAME_NAME}:127.0.0.1" --hostname ${HOSTNAME_NAME} --name ${HOSTNAME}-gazebo \
		-v ${PERSISTENT_GZ}/home:/home \
		-v ${HOME}/.gitconfig:/home/robot/.gitconfig:ro \
		-v ${HOME}/.ssh:/home/robot/.ssh:ro \
		-v ${PERSISTENT_GZ}/runtime-robot:/tmp/runtime-robot \
		-v ${PRJ_DIR}:/home/robot/projects \
		-v /dev/shm:/dev/shm \
	${OWNER}/${ROS_DISTRO}-enviroment-gazebo

rm-persistent-data:
	rm -rf ${HOME}/tmp/${OWNER}
	
repo-rm:
	rm -rf gazebo/tmp/*
	rm -rf bridge/tmp/*
	rm -rf pathfollowing/tmp/*
	
repo-clone:	
	git clone --branch noetic-devel     git@github.com:ros-simulation/gazebo_ros_pkgs.git    gazebo/tmp/ws00/src/gazebo_ros_pkgs
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_msgs.git             gazebo/tmp/ws00/src/tuw_msgs
	git clone --branch noetic-devel     git@github.com:tuw-robotics/tuw_gazebo.git           gazebo/tmp/ws01/src/tuw_gazebo
	git clone --branch master           git@github.com:tuw-robotics/tuw_launches.git         gazebo/tmp/ws01/src/tuw_launches

	git clone --branch master           git@github.com:tuw-robotics/stage_ros.git            bridge/tmp/ws00/src/stage_ros
	
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_msgs.git             pathfollowing/tmp/ws00/src/tuw_msgs
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_geometry.git         pathfollowing/tmp/ws00/src/tuw_geometry
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_multi_robot.git      pathfollowing/tmp/ws01/src/tuw_multi_robot
	git clone --branch master           git@github.com:tuw-robotics/tuw_rviz.git             pathfollowing/tmp/ws01/src/tuw_rviz
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_diffdrive.git        pathfollowing/tmp/ws01/src/tuw_diffdrive
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_control.git          pathfollowing/tmp/ws01/src/tuw_control	
	git clone --branch noetic           git@github.com:tuw-robotics/tuw_global_planner.git   pathfollowing/tmp/ws01/src/tuw_global_planner	
	git clone --branch master           git@github.com:tuw-robotics/tuw_launches.git         pathfollowing/tmp/tuw/src/tuw_launches
	

repo-update:
	find ./gazebo/tmp -name .git -exec git --git-dir={} pull \;
	find ./bridge/tmp -name .git -exec git --git-dir={} pull \;
	find ./pathfollowing/tmp -name .git -exec git --git-dir={} pull \;
