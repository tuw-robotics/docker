# Cocker Containers

## Build 
### Base System
Select your container you like to build and check the related Readme.md

* [ubuntu-noetic](ubuntu-noetic/)
* [ubuntu-noetic-turbovnc](ubuntu-noetic-turbovnc/)

### robot System
Select your container you like to build and check the related Readme.md

* [robot-iwos](robot-iwos/)

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


