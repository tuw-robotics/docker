# tuw:mrrp
## Precondition
Build the [tuw:noetic](../../base) base image first
## Creating Container
1. Build Container <br>
`docker build -f Dockerfile-mrrp -t tuw:mrrp .`
2. You have two options to start the container
  *	start container and use ther terminal <br> `docker run --privileged -ti --network="host" --env="DISPLAY" tuw:mrrp`
  * persistent container and use a vnc such as turbovnc client to connect to the container.
3. Start the demo. 
  * The following commands are also accessible using the arrow up button from your .bash_history file.
  * Split your terminal: <br>`tmux new -s mrrp \; split-window -v \; split-window -v \; select-pane -t 0 \; attach`
  * Launch a demo in one view: <br>`roslaunch tuw_multi_robot_demo demo.launch room:=warehouse032  nr_of_robots:=14`
  * Send goal locations using a other view: <br>`rosrun tuw_multi_robot_goal_generator goals_random _nr_of_robots:=32 _distance_boundary:=0.6 _distance_to_map_border:=0.2 _nr_of_avaliable_robots:=14`
```
export NAME=mrrp
export IMAGE=tuw:mrrp
docker create --name $NAME --privileged --hostname=$NAME --add-host $NAME:127.0.0.1  --interactive  --network="host"   --env="DISPLAY" $IMAGE
docker container start $NAME
docker container exec -it $NAME bash
```

