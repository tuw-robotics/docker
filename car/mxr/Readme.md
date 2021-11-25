# mxr

```
docker build -t robotics:mxr .
```

Then, run it:
```
docker run --privileged -ti --network="host" robotics:mxr
```

Create a permanent container
```
export NAME=mxr
export IMAGE=robotics:mxr
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
