# base-ros base-ros2

This is a container TurboVNC and Ubuntu XFCE desktop.

First, get the image by cloning this repository and building it:

```
export ROS_DISTRO=noetic
export ROS_DISTRO=galactic
docker build -f Dockerfile-ros -t tuw:$ROS_DISTRO --build-arg MY_PASSWORD=xyz431 --build-arg ROS_DISTRO=$ROS_DISTRO .
```

Then, run it:
```
docker run --privileged -ti --hostname=ros --network="host"  --env="DISPLAY" tuw:$ROS_DISTRO

```

Create a permanent container
```
export NAME=$ROS_DISTRO
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  tuw:$ROS_DISTRO
docker container start $NAME
docker container exec -it $NAME bash
```
