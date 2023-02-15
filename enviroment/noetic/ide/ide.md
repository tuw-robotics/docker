# Noetic IDE
registry.auto.tuwien.ac.at/roblab/docker/focal/noetic-enviroment-ide

## useful commands:
```
source /opt/ros/noetic/setup.bash
/opt/TurboVNC/bin/vncserver -kill :1                          # start VNC
/opt/TurboVNC/bin/vncserver -localhost -securitytypes NONE :1 # kill VNC
docker exec -it $HOSTNAME-ide bash -c 'cd $HOME/projects/ros; exec "${SHELL:-sh}"'
```
