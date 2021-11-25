# robotics-base

This is a container TurboVNC and Ubuntu XFCE desktop.

First, get the image by cloning this repository and building it:
```
docker build -t robotics:base .
```

Then, run it:
```
docker run --privileged -ti --network="host" robotics:base
```

Create a permanent container
```
export NAME=ros
export IMAGE=robotics:base
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
