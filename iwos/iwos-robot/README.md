# tuw-iwos

This folder is for the development and operation of the Independent Wheel Offset Steering robot prototype.
This folder contains a `Dockerfile` to build a Docker image specific to the Independent Wheel Offset Steering robot prototype.

To ease the use of the `Dockerfile` a `Makefle` is provided.

The `Makefile` requires the environment variable `CONTAINER_OWNER` to be set.
This should be your dockerhub username.
This can be done by writing the following in the terminal:
```bash
export CONTAINER_OWNER=<dockerhub username>
```
You can also add this to your `.bashrc` file, this way this variable will be set as desired by default.

## Building
Building this container requires the `tuw-noetic-ide` container.
Build that container first, for this reason please check out `enviroment/README.md`.

To build the image the sources for the Independent Wheel Offset Steering robot prototype are required.
The `Makefile` eases the process of cloning the required repositories with the command:

```bash
make git_clone branch="<branch_name>" ws="<workspace (ws00 or ws01)>" repo="<repo_url>"
```
The suggested setup is acheived with the following commands:
```bash
make git_clone branch="noetic" ws="ws00" repo=git@github.com:tuw-robotics/tuw_geometry.git
make git_clone branch="noetic" ws="ws00" repo=git@github.com:tuw-robotics/tuw_msgs.git
make git_clone branch="noetic" ws="ws00" repo=git@github.com:tuw-robotics/tuw_teleop.git

make git_clone branch="noetic" ws="ws01" repo=git@github.com:tuw-robotics/tuw_iwos.git
make git_clone branch="noetic" ws="ws01" repo=git@github.com:tuw-robotics/tuw_hardware_interface.git
make git_clone branch="noetic" ws="ws01" repo=git@github.com:tuw-robotics/tuw_sensor.git 
```
For new builds it is important to keep the sources up to date, for this reason pull all changes from the repositories with:
```bash
make git_pull
```
This will pull the latest state from all repositories from their current branch.

When the sources are cloned and up to date, you can build the container with:
```bash
make build
```
If it is desired to build the container without using the Docker cache run:
```bash
make build_no_cashe
```
Both commands above will create a docker image with the name `<CONTAINER_OWNER>/tuw-noetic-iwos-robot:latest`.

## Pushing
When the image is built, and you want to push it you can run the following command:
```bash
make docker_push
```
Again, the environment variable `CONTAINER_OWNER` is required.

If you are not logged into dockerhub in yut terminal already you can login iwth the following command:
```bash
make docker_login
```

## Pulling
When the image is build and pushed it is time to pull the image onto the robot.
Again, the environment variable `CONTAINER_OWNER` is required.
You can pull the image with:
```bash
make docker_pull
```

A prebuilt version of this docker container can be pulled with:
```bash
docker pull ekrobotics/tuw-noetic-iwos-robot:latest
```
Note that this version might be outdated.

## Running
Finally, with the docker image on the robot you can run:
```bash
make docker_run
```
This will start the docker container in the desired configuration.
The container might ask for a password at start, the password is `password`.
Finally, you can launch the nodes to operate the robot with the following command in the running container:
```
roslaunch tuw_iwos_launches robot.launch
```

_Note:_ please check out the documentation of the [`tuw_iwos` repository](https://github.com/tuw-robotics/tuw_iwos) for more details on the operation of the Independent Wheel Offset Steering.
