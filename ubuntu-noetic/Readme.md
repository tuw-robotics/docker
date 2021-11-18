# ubuntu-noetic

This is a container Ubuntu ros desktop

First, get the image by cloning this repository and building it:
```
docker build -t ubuntu:noetic --build-arg MY_PASSWORD=asdf431 .
```

Then, run it:
```
docker run -ti --network="host" ubuntu:noetic
```

Create a permanent container
```
export NAME=ros
export IMAGE=ubuntu:noetic
docker create --name $NAME  --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
