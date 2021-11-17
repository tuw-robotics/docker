# robot-iwos


First, get the image by cloning this repository and building it:
```
docker build -t robot:iwos --build-arg SSH_KEYS=$HOME/.ssh .
```

Then, run it:
```
docker run --privileged -ti --network="host" robot:iwos
```

Create a permanent container
```
export CONTAINER_HOST_NAME=ros
export CONTAINER_NAME=robot:iwos
docker create --name $CONTAINER_HOST_NAME --privileged --hostname=$CONTAINER_HOST_NAME --add-host $CONTAINER_HOST_NAME:127.0.0.1  --interactive  --network="host"  $CONTAINER_NAME
docker container start $CONTAINER_HOST_NAME
docker container exec -it $CONTAINER_HOST_NAME bash
```
