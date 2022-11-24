# Gazebo on noetic
registry.auto.tuwien.ac.at/roblab/docker/focal/noetic-enviroment-gazebo

## useful commands:
```
roslaunch tuw_gazebo_models room_world.launch room:=roblab
roslaunch tuw_gazebo_models room_world.launch room:=cave
roslaunch tuw_gazebo_models pioneer3dx.gazebo.launch motor_plugin:=diff_twist differential_odom_source:=encoder
roslaunch tuw_gazebo_models r1_rviz.launch
tmux new -s gz \; split-window -v \; select-pane -t 1 \; split-window -v \; select-pane -t 0 \; attach
```
