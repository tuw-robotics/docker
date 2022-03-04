# robot-iwos
## Docker
1. Build Container <br>
`docker build -t robotics:mrrp .`
2. You have two options to start the container
  *	start container<br> `docker run --privileged -ti --network="host" robotics:mrrp`
  * persistent container
```
export NAME=mrrp
export IMAGE=robot:mrrp
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```

