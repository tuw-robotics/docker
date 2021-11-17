# ubuntu-noetic

This is a container Ubuntu ros desktop

First, get the image by cloning this repository and building it:
```
docker build -t ubuntu:noetic .
```

Then, run it:
```
docker run -ti --network="host" ubuntu:noetic
```

Create a permanent container
```
export CONTAINER_HOST_NAME=ros
export CONTAINER_NAME=ubuntu:noetic
docker create --name $CONTAINER_HOST_NAME  --hostname=$CONTAINER_HOST_NAME --add-host $CONTAINER_HOST_NAME:127.0.0.1  --interactive  --network="host"  $CONTAINER_NAME
docker container start $CONTAINER_HOST_NAME
docker container exec -it $CONTAINER_HOST_NAME bash
```
