# tuw_base container
This container is base on `mxcar:base` and more stuff

## Requirements
Docker installation

## Build
```
docker build -t mxcar:devel .
xhost +si:localuser:root
docker create --name mxcar-devel --hostname=mxcar-devel  --interactive  --network="host"  mxcar:devel
docker container start mxcar-devel
docker container exec  -it mxcar-devel bash
```
