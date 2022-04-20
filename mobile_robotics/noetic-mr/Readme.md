# tuw:noetic-mr
## Precondition
Build the [tuw:noetic](../../base) base image first
## Creating Container
Image this image is used for the mobile robotics lecture

```
docker build -f Dockerfile-noetic-mr -t tuw:noetic-mr .
```

Then, run it:
```
docker run --privileged -ti --network="host" --hostname=noetic-mr --env="DISPLAY" -v $HOME/.ssh:/home/robot/.ssh:ro tuw:noetic-mr
```

Create a permanent container
```
export NAME=noetic-mr
export IMAGE=tuw:$NAME
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
