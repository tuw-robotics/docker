# tuw:galactic-mr
## Precondition
Build the [tuw:galactic](../../base) base image first
## Creating Container
Image this image is used for the mobile robotics lecture

```
docker build -f Dockerfile-galactic-mr -t tuw:galactic-mr .
```

Then, run it:
```
docker run --privileged -ti --network="host" --env="DISPLAY" -v $HOME.ssh:/home/robot/.ssh:ro tuw:galactic-mr
```

Create a permanent container
```
export NAME=galactic-mr
export IMAGE=tuw:$NAME
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
