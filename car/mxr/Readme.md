# mxr

```
docker build -t robotics:mxr .
```

Then, run it:
```
docker run --privileged -ti --network="host" -v ~/.ssh:/home/robot/.ssh:ro robotics:mxr
```

Create a permanent container
```
export NAME=mxr
export IMAGE=robotics:mxr
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive -v ~/.ssh:/home/robot/.ssh:ro --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
## Update git repos

```
cd ~/projects/car
mr -c mrconfig update
