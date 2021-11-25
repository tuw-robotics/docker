# mr2021
Image this image is used for the mobile robotics lecture

```
docker build -t robotics:mr2021 .
```

Then, run it:
```
docker run --privileged -ti --network="host" robotics:mr2021
```

Create a permanent container
```
export NAME=mr
export IMAGE=robotics:mr2021
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
