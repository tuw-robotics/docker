# ROS1 und ROS2 Docker images

## Build docker images
Checkout the Makefiles in
- [noetic](noetic)
- [galactic](galactic)

and run
- `make build`              --> build all images
- `make login USER=mbader`  --> authenticate container Registry
- `make pull`               --> pull all images
- `make push`               --> push all images
- `make clean`              --> remove all images


## ubuntu:focal  (default)
```
make build OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal ROOT_CONTAINER=ubuntu:focal 
make push  OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal
make pull  OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal
```
## nvidia/cuda:11.7.0-runtime-ubuntu20.04 
One can also use an nvidia image as ROOT_CONTAINER like
```
make build OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal-nvidia ROOT_CONTAINER=nvidia/cuda:11.7.0-runtime-ubuntu20.04 
make push  OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal-nvidia
make pull  OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal-nvidia
```
