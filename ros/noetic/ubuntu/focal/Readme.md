# ROS Docker files


## build

```
docker build -t registry.auto.tuwien.ac.at/roblab/docker/focal/noetic-core             --build-arg ROOT_CONTAINER=ubuntu:focal  ros-core/.
docker build -t registry.auto.tuwien.ac.at/roblab/docker/focal/noetic-base             --build-arg OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal  ros-base/.
docker build -t registry.auto.tuwien.ac.at/roblab/docker/focal/noetic-robot-focal      --build-arg OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal  robot/.
docker build -t registry.auto.tuwien.ac.at/roblab/docker/focal/noetic-perception-focal --build-arg OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal  perception/.
```

```
docker build -t registry.auto.tuwien.ac.at/roblab/docker/noetic-ros-core-focal-nvidia --build-arg ROOT_CONTAINER=nvidia/cuda:11.7.0-runtime-ubuntu22.04  ros-core/.
```
