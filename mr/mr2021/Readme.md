# mr2021
Image this image is used for the mobile robotics lecture

```
docker build -t mr2021 .
```

Then, run it:
```
docker run --privileged -ti --network="host" mr2021
```

Create a permanent container
```
export NAME=mr
export IMAGE=mr2021
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
