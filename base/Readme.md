# base container
This container is base on `dorowu:ubuntu-desktop-lxde-vnc` 

## Requirements
Docker installation

## Build

```
docker build -t mxcar:base .
docker create --name mxcar_base  --hostname=car00  --interactive  --network="host"  -e USER=robot -e PASSWORD=password -v /dev/shm:/dev/shm mxcar:base
docker container start mxcar_base
docker container exec  -it mxcar_base bash
```
