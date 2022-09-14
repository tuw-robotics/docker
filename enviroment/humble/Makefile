ROS_DISTRO = humble
OWNER = registry.auto.tuwien.ac.at/roblab/docker/jammy
ROOT_CONTAINER = ${OWNER}/${ROS_DISTRO}-desktop

RUN = enviroment-desktop

all: help

help:
	@echo ""
	@echo "-- Help Menu for ROS ${ROS_DISTRO} based on $$\$${ROOT_CONTAINER}"
	@echo ""
	@echo "   global options with defaults:"
	@echo "     ROS_DISTRO=humble"
	@echo "     OWNER=registry.auto.tuwien.ac.at/roblab/docker/jammy"
	@echo "     ROOT_CONTAINER=$$\$${OWNER}/humble-desktop"
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
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-core             --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}   core/.
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-desktop          --build-arg OWNER=${OWNER}/${ROS_DISTRO}       desktop/.
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-ide              --build-arg OWNER=${OWNER}/${ROS_DISTRO}       ide/.
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-gazebo           --build-arg OWNER=${OWNER}/${ROS_DISTRO}       gazebo/.

push:
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-desktop
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-ide
	@docker push ${OWNER}/${ROS_DISTRO}-enviroment-gazebo
	
pull:
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-desktop
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-ide
	@docker pull ${OWNER}/${ROS_DISTRO}-enviroment-gazebo

clean:
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-core
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-desktop
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-ide
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-enviroment-gazebo

run:
	@echo ${OWNER}/${ROS_DISTRO}-${RUN}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${RUN}:127.0.0.1" --name ${RUN} ${OWNER}/${ROS_DISTRO}-${RUN}

run-ide:
	mkdir -p /tmp/docker-ide/vscode
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${ROS_DISTRO}:127.0.0.1" --hostname ${ROS_DISTRO} --name ${ROS_DISTRO} \
		-v ~/.ssh:/home/robot/.ssh:ro -v ~/.gitconfig:/home/robot/.gitconfig:ro \
		-v /tmp/docker-ide/runtime-robot:/home/robot/.vscode \
		-v ~/projects:/home/robot/projects \
	${OWNER}/${ROS_DISTRO}-enviroment-ide
	
run-gz:
	mkdir -p /tmp/docker-gazebo/runtime-robot /tmp/docker-gazebo/gazebo /tmp/docker-gazebo/ignition /tmp/docker-gazebo/sdformat
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "gazebo:127.0.0.1" --hostname gazebo --name gazebo \
		-v ~/.gitconfig:/home/robot/.gitconfig:ro \
		-v ~/.ssh:/home/robot/.ssh:ro -v ~/.gitconfig:/home/robot/.gitconfig:ro \
		-v /tmp/docker-gazebo/runtime-robot:/tmp/runtime-robot \
		-v /tmp/docker-gazebo/gazebo:/home/robot/.gazebo \
		-v /tmp/docker-gazebo/ignition:/home/robot/.ignition \
		-v /tmp/docker-gazebo/sdformat:/home/robot/.sdformat \
	${OWNER}/${ROS_DISTRO}-enviroment-gazebo

repo-checkout:
	git clone --branch ros2      git@github.com:ros-simulation/gazebo_ros_pkgs.git      gazebo/tmp/ws00/src/gazebo_ros_pkgs
	git clone --branch galactic  git@github.com:tuw-robotics/tuw2_gazebo.git            gazebo/tmp/ws01/src/tuw2_gazebo


repo-update:
	find ./mpc -name .git -exec git --git-dir={} pull \;
