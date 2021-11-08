# docker container for mxcar

## Build
In oder to build the docker containers build first base followed by devel

* [base](base/)
* [devel](devel/)

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
export CONTAINER_NAME=mxcar_base
docker container stop ${CONTAINER_NAME}; docker container rm ${CONTAINER_NAME}
```


