# base-ros base-ros2

This is a container TurboVNC and Ubuntu XFCE desktop.

First, get the image by cloning this repository and building it:

```
export ROS_VERSION=ros
#or
export ROS_VERSION=ros2

docker build -f Dockerfile-$ROS_BASE  -t tuw:base-$ROS_VERSION --build-arg MY_PASSWORD=xyz431 .
```

Then, run it:
```
docker run --privileged -ti --hostname=ros --network="host"  --env="DISPLAY" tuw:base-$ROS_VERSION

```

Create a permanent container
```
export NAME=$ROS_VERSION
export IMAGE=tuw:base-$ROS_VERSION
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
