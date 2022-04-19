# tuw-iwos
Image for the iwos development

```
docker build -t tuw:iwos .
```

Then, run it:
```
docker run --privileged -ti --network="host" --device=/dev/ttyUSB0 --device=/dev/ttyACM0 --device=/dev/ttyACM1 --device=/dev/input/js0 robotics:iwos
```

In order to give access to the gamepad run the following command in the container (the default password is `xyz`):
```
sudo chmod 777 /dev/input/js0
```

Create a permanent container
```
export NAME=ros
export IMAGE=robot:iwos
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"  $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```
