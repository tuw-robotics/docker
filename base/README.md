# ROS1 and ROS2 basic docker image

This is a basic docker image for ROS1 and ROS2.
It is equipped with the ros basics as well as some basic bash tools.

Optional it can be equipped with an SSH server, a VNC server and an IDE / editor (VS Code, Geany, KDevelop)

The container serves as base for  tuw-robotics docker containers such as:
* [Race_Car](../car)
* [Gazebo](../gazebo)
* [iwos](../iwos)
* [Mobile Robotics](../mobile_robotics)
* [MPN](../mpn)
* [Multi Robot Route Planner](../tuw_multi_robot)

## Creating Container
Set a ROS distro. Currently, the following are supported:
ROS1:
- noetic (`export ROS_DISTRO=noetic`)
ROS2:
- galactic (`export ROS_DISTRO=galactic`)

To build the container:
```bash
docker build -t tuw:$ROS_DISTRO . \
  --build-arg ROS_DISTRO=$ROS_DISTRO \
  --build-arg MY_PASSWORD=password
```
Note: that the password is required to login to the container.

The following build arguments are available:
- `ROS_DISTRO`: the ROS distro to use (default: `noetic`)
- `INSTALL_SSH`: install ssh server (default: `true`)
- `INSTALL_VNC`: install turboVNC server (default: `true`)
- `INSTALL_CODE`: install VS Code (default: `true`)
- `INSTALL_GEANY`: install Geany (default: `true`)
- `INSTALL_KDEVELOP`: install KDevelop (default: `true`)
- `MY_USER`: user (default: `robot`)
- `MY_NAME`: name of the user (default: `Robot`)
- `MY_PASSWORD`: password (default: `password`)
- `MY_UID`: user id (default: `1000`)
- `MY_GID`: group id (default: `1000`)
- `TZ`: timezone (default: `Europe/Vienna`)

To run the container:
```bash
docker run --privileged -ti --hostname=ros --network="host"  --env="DISPLAY" tuw:$ROS_DISTRO
```

Create a permanent container
```bash
export NAME=$ROS_DISTRO
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  tuw:$ROS_DISTRO
docker container start $NAME
docker container exec -it $NAME bash
```
