# robot-iwos
Image for the iwos development

```
docker build -t robot:iwos .
```

Then, run it:
```
docker run --privileged -ti --network="host" robot:iwos
```

Create a permanent container
```
export NAME=ros
export IMAGE=robot:iwos
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
