# tuw:melodic-mpn
## Creating Container

```
docker build -f Dockerfile-melodic-mpn -t tuw:melodic-mpn .
```

Then, run it:
```
docker run --privileged -ti --network="host" --hostname=melodic-mpn --env="DISPLAY" -v $HOME/.ssh:/home/robot/.ssh:ro tuw:melodic-mpn
```

Create a permanent container
```
export NAME=my_mpn
export IMAGE=tuw:melodic-mpn
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  --env="DISPLAY" -v $HOME/.ssh:/home/robot/.ssh:ro  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
