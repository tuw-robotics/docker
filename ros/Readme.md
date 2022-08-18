# ROS1 und ROS2 Docker images

## checkout the Makefiles in
- [noetic](noetic)
- [galactic](galactic)

run:
- make build              - build all images"
- make login USER=mbader  - authenticate container Registry"
- make pull               - pull all images"
- make push               - push all images"
- make clean              - remove all images"

## nvidia
One can also use an nvidia image as ROOT_CONTAINER like

```
make build OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal/nvidia ROOT_CONTAINER=nvidia/cuda:11.7.0-runtime-ubuntu22.04 
make push  OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal/nvidia
make pull  OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal/nvidia
```
