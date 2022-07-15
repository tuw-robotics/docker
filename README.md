# Docker Containers

This repository contains the Dockerfiles and according scripts for the tuw_docker images.

## Containers
Check out the `README.md` for the container you are interested in.
The base container is designed to work either for ROS1 or ROS2 and has some basic tools  installed.
Other containers are build with the base container.

* ROS1+2 base system [tuw_docker:tuw_noetic_base or tuw_docker:tuw_galactic_base](./base/):
* TUW Gazebo [tuw:gazebo](./gazebo/)
* Independent Wheel Offset Steering (IWOS) [tuw:iwos](./iwos/)
* Mobile Robotics Framework [mobile_robotics](./mobile_robotics)
* Multi Robot Route Planner Framework [tuw_multi_robot](./tuw_multi_robot/mrrp/)

### robot System
Select your container you like to build and check the related Readme.md

* [robot-iwos](./iwos/robot-iwos/Readme.md)

## Useful commands and operations for Docker

The following commands are useful for the operation of Docker and are generally applicable.

### Delete images

#### Delete a single image
To delete a image:
```bash
docker image rm <image_name>
```

#### Delete all images
To delete all images:
```bash
docker image rm -f $(docker images -a -q)
```

### Delete container

#### Delete a singe container
To delete a container run:
```bash
docker container rm <container_name>
```
When the container is still running stop the container before deleting:
```bash
docker container stop <container_name>
```
Alternatively the process of deleting can be forced:
```bash
docker container rm -f <container_name>
```

#### Delete all stopped containers
To delete all stopped containers:
```bash
docker contaier rm $(docker container ls -a -q -f status=exited)
```

### Moving docker data container
```
sudo service docker stop
sudo vim /etc/docker/daemon.json 
```
```
{ 
   "data-root": "/path/to/your/docker" 
}
```
```
sudo rsync -aP /var/lib/docker/ /path/to/your/docker
sudo mv /var/lib/docker /var/lib/docker.old
sudo service docker start
# sudo rm -rf /var/lib/docker.old
```


