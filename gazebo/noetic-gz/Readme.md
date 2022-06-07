# tuw:noetic-mr
## Precondition
Build the [tuw:noetic](../../base) base image first
## Creating Container

```
docker build -f Dockerfile-noetic-gz -t tuw:noetic-gz .
```

Then, run it:
```
docker run --privileged -ti --network="host" --hostname=noetic-mr --env="DISPLAY" -v $HOME/.ssh:/home/robot/.ssh:ro tuw:noetic-gz
```

Create a permanent container
```
export NAME=my_gz
export IMAGE=tuw:noetic-gz
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  --env="DISPLAY" -v $HOME/.ssh:/home/robot/.ssh:ro  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
