# ubuntu-turbovnc

This is a container TurboVNC and Ubuntu XFCE desktop.

First, get the image by cloning this repository and building it:
```
docker build -t ubuntu:turbovnc .
```

Then, run it:
```
docker run -ti --network="host" ubuntu:turbovnc
```

Create a permanent container
```
export CONTAINER_NAME=ubuntu-ros-turbovnc
docker create --name $CONTAINER_NAME  --hostname=$CONTAINER_NAME --add-host $CONTAINER_NAME:127.0.0.1  --interactive  --network="host"  ubuntu:turbovnc
docker container start $CONTAINER_NAME
docker container exec -it $CONTAINER_NAME bash
```
