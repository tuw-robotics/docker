ROS_DISTRO = humble
OWNER = registry.auto.tuwien.ac.at/roblab/docker/jammy
ROOT_CONTAINER = ${OWNER}/${ROS_DISTRO}-desktop
PRJ_DIR = ${HOME}/projects

RUN = enviroment-desktop

PERSISTENT_IDE = ${HOME}/tmp/${OWNER}/${ROS_DISTRO}-enviroment-ide
PERSISTENT_GZ  = ${HOME}/tmp/${OWNER}/${ROS_DISTRO}-enviroment-gazebo
	
all: help

help:
	@echo ""
	@echo "   Help Menu for ROS ${ROS_DISTRO} based on:"
	@echo "   ${ROOT_CONTAINER}"
	@echo ""
	@echo "   global options with defaults:"
	@echo "    - ROS_DISTRO     = humble"
	@echo "    - OWNER          = registry.auto.tuwien.ac.at/roblab/docker/jammy"
	@echo "    - ROOT_CONTAINER = \044{OWNER}/\044{ROS_DISTRO}-desktop"
	@echo "    - RUN            = ${RUN}"
	@echo "    - PRJ_DIR        = ${PRJ_DIR}"
	@echo ""
	@echo "   make build              - build all images"
	@echo "   make login USER=mbader  - authenticate container Registry"
	@echo "   make pull               - pull all images"
	@echo "   make push               - push all images"
	@echo "   make clean              - remove all images"
	@echo "   make run                - runs the image: \044{OWNER}/\044{ROS_DISTRO}/\044{RUN}"
	@echo "   make run-gz             - runs the image: ${OWNER}/${ROS_DISTRO}-enviroment-gazebo"
	@echo "   make run-ide            - runs the image: ${OWNER}/${ROS_DISTRO}-enviroment-ide and mounts \044{${PRJ_DIR} to ~/projects"
	@echo "   make repo-checkout      - clones repositories needed for builds"
	@echo "   make repo-update        - updates repositories needed for builds"
	@echo ""
	@echo "  Example:"
	@echo "   make run RUN=enviroment-ide PRJ_DIR=${HOME}/Projects"
	@echo "   make run-ide PRJ_DIR=${HOME}/Projects"

login:
	@docker login registry.auto.tuwien.ac.at -u ${USER}
	
build-core:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-core             --build-arg ROOT_CONTAINER=${ROOT_CONTAINER}   core/.
	
build-ide:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-ide              --build-arg OWNER=${OWNER}/${ROS_DISTRO}       ide/.
	
build-desktop:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-desktop          --build-arg OWNER=${OWNER}/${ROS_DISTRO}       desktop/.

build-gazebo:
	@docker build --rm -t ${OWNER}/${ROS_DISTRO}-enviroment-gazebo           --build-arg OWNER=${OWNER}/${ROS_DISTRO}       gazebo/.
	
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

# creates a folder for the contaners persistend data therefore it copies of an emty container home directory 
# ToDo: this can be fused with the target ${PERSISTENT_GZ}:
${PERSISTENT_IDE}:
	@echo create PERSISTENT_IDE folder: ${PERSISTENT_IDE}
	@mkdir -p ${PERSISTENT_IDE}/home
	@echo "Run the following command in your container"
	@echo " rsync -av /home/robot /tmp/home; exit"
	@docker run --rm -ti -v ${PERSISTENT_IDE}/home:/tmp/home ${OWNER}/${ROS_DISTRO}-enviroment-ide

# runs the ide container and mounts a persistent folder as home 
run-core: 
	@docker run -ti --rm --privileged --network="host" --add-host "${ROS_DISTRO}-core:127.0.0.1" --hostname ${ROS_DISTRO}-core --name ${ROS_DISTRO}-core \
	${OWNER}/${ROS_DISTRO}-enviroment-core
	
# runs the ide container and mounts a persistent folder as home 
run-ide: ${PERSISTENT_IDE}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${ROS_DISTRO}:127.0.0.1" --hostname ${ROS_DISTRO} --name ${ROS_DISTRO} \
		-v ${PERSISTENT_IDE}/home:/home \
		-v ~/.ssh:/home/robot/.ssh:ro \
		-v ~/.gitconfig:/home/robot/.gitconfig:ro \
		-v ${PRJ_DIR}:/home/robot/projects \
		-v /dev/shm:/dev/shm \
	${OWNER}/${ROS_DISTRO}-enviroment-ide
	
# creates a folder for the contaners persistend data therefore it copies of an emty container home directory 
# ToDo: this can be fused with the target ${PERSISTENT_IDE}:
${PERSISTENT_GZ}:
	@echo create PERSISTENT_GZ folder: ${PERSISTENT_GZ}
	@mkdir -p ${PERSISTENT_GZ}/home \
	          ${PERSISTENT_GZ}/runtime-robot
	@chmod 0700 -R ${PERSISTENT_GZ}/runtime-robot
	@echo "Run the following command in your container"
	@echo " rsync -av /home/robot /tmp/home; exit"
	@docker run --rm -ti -v ${PERSISTENT_GZ}/home:/tmp/home ${OWNER}/${ROS_DISTRO}-enviroment-gazebo
	
# runs the gazebo container and mounts a persistent folder as home 
run-gz-dev: ${PERSISTENT_GZ}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "gazebo:127.0.0.1" --hostname gazebo --name gazebo \
		-v ${PERSISTENT_GZ}/home:/home \
		-v ${HOME}/.gitconfig:/home/robot/.gitconfig:ro \
		-v ${HOME}/.ssh:/home/robot/.ssh:ro \
		-v ${PERSISTENT_GZ}/runtime-robot:/tmp/runtime-robot \
		-v /dev/shm:/dev/shm \
	${OWNER}/${ROS_DISTRO}-enviroment-gazebo

# runs the gazebo container
run-gz: ${PERSISTENT_GZ}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "gazebo:127.0.0.1" --hostname gazebo --name gazebo \
		-v ${HOME}/.sdformat:/home/robot/.sdformat \
		-v ${HOME}/.ignition:/home/robot/.ignition \
		-v ${HOME}/.gazebo:/home/robot/.gazebo \
		-v ${PERSISTENT_GZ}/runtime-robot:/tmp/runtime-robot \
		-v /dev/shm:/dev/shm \
	${OWNER}/${ROS_DISTRO}-enviroment-gazebo
	
repo-checkout:
	git clone --branch ros2      git@github.com:ros-simulation/gazebo_ros_pkgs.git      gazebo/tmp/ws00/src/gazebo_ros_pkgs
	git clone --branch ros2      git@github.com:tuw-robotics/tuw2_gazebo.git            gazebo/tmp/ws01/src/tuw2_gazebo


repo-update:
	find ./mpc -name .git -exec git --git-dir={} pull \;
