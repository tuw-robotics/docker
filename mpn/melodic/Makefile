ROS_DISTRO = melodic
OWNER = registry.auto.tuwien.ac.at/roblab/docker/bionic
ROOT_CONTAINER = ${OWNER}/${ROS_DISTRO}-desktop

RUN	= mpc
HOSTNAME := $(shell hostname)

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
	@echo "   make 	               - runs the image: $$\$${OWNER}/$$\$${ROS_DISTRO}/$$\$${RUN}"
	
	@echo ""

login:
	@docker login registry.auto.tuwien.ac.at -u ${USER}
	
    
build: 
	@docker build  --rm -t ${OWNER}/${ROS_DISTRO}-mpc   --build-arg ROOT_CONTAINER=${OWNER}/${ROS_DISTRO}-enviroment-desktop  mpc/.

push:
	@docker push ${OWNER}/${ROS_DISTRO}-mpc
	
pull:
	@docker pull ${OWNER}/${ROS_DISTRO}-mpc

clean:
	@docker rmi -f ${OWNER}/${ROS_DISTRO}-mpc

run:
	@echo ${OWNER}/${ROS_DISTRO}-${RUN}
	@docker run -ti --rm --privileged --network="host" --env="DISPLAY" --add-host "${HOSTNAME}-mpn:127.0.0.1" --hostname ${HOSTNAME}-mpn --name ${HOSTNAME}-mpn \
		-v /dev/shm:/dev/shm \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
	${OWNER}/${ROS_DISTRO}-${RUN}


update:
	find ./mpc -name .git -exec git --git-dir={} pull \;

checkout: 
	git clone --branch melodic git@github.com:tuw-robotics/grid_map.git             mpc/tmp/ws00/src/grid_map
	git clone --branch master  git@github.com:tuw-robotics/tuw_msgs.git             mpc/tmp/ws00/src/tuw_msgs
	git clone --branch master  git@github.com:tuw-robotics/stage_ros.git            mpc/tmp/ws00/src/stage_ros
	git clone --branch melodic git@github.com:tuw-robotics/tuw_geometry.git         mpc/tmp/ws00/src/tuw_geometry
	git clone --branch master  git@github.com:tuw-robotics/tuw_multi_robot.git      mpc/tmp/ws01/src/tuw_multi_robot  
	git clone --branch master  git@github.com:tuw-robotics/tuw_control.git          mpc/tmp/ws02/src/tuw_control  	
	git clone --branch master  git@github.com:tuw-robotics/tuw_rviz.git             mpc/tmp/ws02/src/tuw_rviz
	git clone --branch master  git@github.com:tuw-robotics/tuw_agv.git              mpc/tmp/ws02/src/tuw_agv
	git clone --branch master  git@github.com:tuw-robotics/tuw_teleop.git           mpc/tmp/ws02/src/tuw_teleop
	git clone --branch master  git@github.com:tuw-robotics/tuw_collision_alarm.git  mpc/tmp/ws02/src/tuw_collision_alarm
	git clone --branch master  git@github.com:tuw-robotics/tuw_global_planner.git   mpc/tmp/ws02/src/tuw_global_planner    
	git clone --branch master  git@github.com:tuw-robotics/tuw_diffdrive.git        mpc/tmp/ws03/src/tuw_diffdrive    
	git clone --branch master  git@github.com:tuw-robotics/tuw_mpn.git              mpc/tmp/ws03/src/tuw_mpn    
	git clone --branch master  git@github.com:tuw-robotics/tuw_nav_costmap.git      mpc/tmp/ws03/src/tuw_nav_costmap    
	git clone --branch master  git@github.com:tuw-robotics/tuw_launches.git         mpc/tmp/tuw/src/tuw_launches
#  	git clone --branch master  git@github.com:tuw-robotics/tuw_gazebo.git           mpc/tmp/tuw/src/tuw_gazebo
