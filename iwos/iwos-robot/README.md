# tuw-iwos

This image is for the development of the IWOS robot.
To build this image run:
```bash
docker build -t tuw_docker:tuw_noetic_iwos .
```

In order to start a container with this image run:
```
docker run --privileged -ti --network="host" --device=/dev/ttyUSB0 --device=/dev/ttyACM0 --device=/dev/ttyACM1 --device=/dev/input/js0 tuw_docker:tuw_noetic_iwos
```

## Image repository
The base image and the iwos image (which build on the base image) are pushed to dockerhub in [this](https://hub.docker.com/repository/docker/ekrobotics/robotics) repository.
