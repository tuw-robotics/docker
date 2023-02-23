# docker_base
This repo hold docker files to crate a docker container with ROS and supports a multiple options on the build.

* XFCE Desktop 
* TURBO VNC Server
* VSCode
* ROS NAV 
* GAZEBO

For details checkout the Makefile with `make help`

## make
A make file is used to create and run the container


## pull / push
The containers are pushed to dockerhup
```
make pull ROS_DISTRO=humble
make pull ROS_DISTRO=noetic
make pull ROS_DISTRO=melodic
```
```
make login USER=tuwrobotics
make push ROS_DISTRO=humble
make push ROS_DISTRO=noetic
make push ROS_DISTRO=melodic
```

## Demo

### non-persistent container
```
git clone -b master https://github.com/tuw-robotics/docker.git
cd docker/base
make build
# make pull
make run ROS_DISTRO=humble
make run ROS_DISTRO=noetic
```
