# ROS1 und ROS2 Docker images

## checkout the Makefiles 
- noetic
- galactic

## nvidia
One can also use an nvidia image as ROOT_CONTAINER

```
docker build -t registry.auto.tuwien.ac.at/roblab/docker/noetic-ros-core-focal-nvidia --build-arg ROOT_CONTAINER=nvidia/cuda:11.7.0-runtime-ubuntu22.04  ros-core/.
```
