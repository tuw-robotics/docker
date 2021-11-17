# ubuntu20-ros-turbovnc

This is a container TurboVNC and Ubuntu XFCE desktop.

First, get the image by cloning this repository and building it:
```
docker build -t ubuntu20:ros:turbovnc
```

Then, run it:
```
docker run -ti --network="host" ubuntu20:ros:turbovnc
```

Create a permanent container
```
export CONTAINER_HOST_NAME=ubuntu20-ros-turbovnc
export CONTAINER_NAME=ubuntu20:ros:turbovnc
docker create --name $CONTAINER_HOST_NAME  --hostname=$CONTAINER_HOST_NAME --add-host $CONTAINER_HOST_NAME:127.0.0.1  --interactive  --network="host"  $CONTAINER_NAME
docker container start $CONTAINER_HOST_NAME
docker container exec -it $CONTAINER_HOST_NAME bash
```
