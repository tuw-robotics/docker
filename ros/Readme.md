# tuw_base container
This container is base on `noetic:tuw_base` and adds a ros workspace
for tuw_mutli_robot.

## Requirements
Docker installation

## Build
```
docker build -t noetic:tuw_multi_robot .
xhost +si:localuser:root
docker create --name noetic-tuw_multi_robot  --hostname=tuw_multi_robot  --interactive  --network="host"  -v /tmp/.X11-unix:/tmp/.X11-unix   noetic:tuw_multi_robot
docker container start noetic-tuw_multi_robot
docker container exec  -it -e DISPLAY=$DISPLAY noetic-tuw_multi_robot bash
```
