# Cocker Containers

## Build 
### Base System
Select your container you like to build and check the related Readme.md

* ROS1+2 base system [tuw:noetic or tuw:galactic](base/)
* Mobile Robotics Framework [mobile_robotics](mobile_robotics)
* Multi Robot Route Planner Framework [tuw_multi_robot](tuw_multi_robot/mrrp/)

### robot System
Select your container you like to build and check the related Readme.md

* [robot-iwos](./iwos/robot-iwos/Readme.md)

## Utils

### Delete container
#### Delete a singe container
```
export CONTAINER_NAME=my_container
docker container stop ${CONTAINER_NAME}; docker container rm ${CONTAINER_NAME}
```
#### Delete all stoped containers
```
docker ps -a -q -f status=exited | xargs docker rm
```
### Delete images
#### Delete all images
```
docker rmi -f $(docker images -a -q)
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


