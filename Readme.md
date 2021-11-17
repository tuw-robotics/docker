# Ubuntu with ROS and a Turbo VNC-Server

## Build
For details how to build the container check the subfolder [base](base/).

## Utils
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


### Delete container
```
export CONTAINER_NAME=my_container
docker container stop ${CONTAINER_NAME}; docker container rm ${CONTAINER_NAME}
```


