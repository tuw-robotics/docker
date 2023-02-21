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
