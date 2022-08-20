# ROS1 and ROS2 enviroment docker image

This is a basic docker image for ROS1 and ROS2.
It is equipped with the ROS1 or ROS2 as well as some basic bash tools.

Optional it can be equipped with:
- TurboVNC server 
- IDE 
  - VS Code 
  - KDevelop

The container serves as base for tuw-robotics docker containers such as:
* [Race_Car](../car)
* [Gazebo](../gazebo)
* [iwos](../iwos)
* [Mobile Robotics](../mobile_robotics)
* [MPN](../mpn)
* [Multi Robot Route Planner](../tuw_multi_robot)

## Build docker images with __make__
Checkout the Makefile and run
- `make build`              --> build all images
- `make login USER=mbader`  --> authenticate container Registry
- `make pull`               --> pull all images
- `make push`               --> push all images
- `make clean`              --> remove all images
- `make run`                --> runs an images

```
# ROS1 noetic
make build ROS_DISTRO=noetic ROOT_CONTAINER=registry.auto.tuwien.ac.at/roblab/docker/focal/noetic-desktop
make push ROS_DISTRO=noetic
make pull ROS_DISTRO=noetic
# ROS2 galactic
make build ROS_DISTRO=galactic ROOT_CONTAINER=registry.auto.tuwien.ac.at/roblab/docker/focal/galactic-desktop
make push ROS_DISTRO=galactic
```

## Build docker images by hand
Set a ROS distro. Currently, the following are supported:
- ROS1:
  - noetic (`export ROS_DISTRO=noetic`)
- ROS2:
  - galactic (`export ROS_DISTRO=galactic`)

To build the container:
```bash

export ROS_DISTRO=noetic
export OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal
export ROOT_CONTAINER=${OWNER}/noetic-desktop        
# export ROOT_CONTAINER=osrf/ros:${ROS_DISTRO}-desktop

docker build -t ${OWNER}/${ROS_DISTRO}/enviroment-core    core/.    \
   --build-arg ROOT_CONTAINER=${ROOT_CONTAINER} \
   --build-arg MY_USER=robot \
   --build-arg MY_NAME=Robot \
   --build-arg MY_PASSWORD=xyz \
   --build-arg MY_UID=1000 \
   --build-arg MY_GID=1000 \
   --build-arg TZ=Europe/Vienna 

docker build -t $(OWNER)/$(ROS_DISTRO)/enviroment-desktop desktop/.  \
   --build-arg OWNER=${OWNER} \
   --build-arg ROS_DISTRO=${noetic} \
   --build-arg INSTALL_VNC=true
   
docker build -t $(OWNER)/$(ROS_DISTRO)/enviroment-ide     ide/.  \
   --build-arg OWNER=${OWNER} \
   --build-arg INSTALL_CODE=true \
   --build-arg INSTALL_KDEVELOP=false 
   
```

## Running the Container

Run the container:
```bash
export CONTAINER_NAME="tuw_${ROS_DISTRO}_base"  # if not already set
docker run --name ${CONTAINER_NAME} --privileged -ti --hostname=ros --add-host ${CONTAINER_NAME}:127.0.0.1 --network="host" --env="DISPLAY" tuw_docker:${CONTAINER_NAME}
```

Create a permanent container
```bash
export CONTAINER_NAME="tuw_${ROS_DISTRO}_base"  # if not already set
docker create --name ${CONTAINER_NAME} --privileged -ti --hostname=ros --add-host ${CONTAINER_NAME}:127.0.0.1 --network="host" --env="DISPLAY" tuw_docker:${CONTAINER_NAME}
docker container start ${CONTAINER_NAME}
docker container exec -it ${CONTAINER_NAME} bash
```
