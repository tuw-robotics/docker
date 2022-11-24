# Mobile Robotics
registry.auto.tuwien.ac.at/roblab/docker/focal/noetic-enviroment-mobile-robotics

## useful commands:
```
# ROS
source /opt/ros/noetic/setup.bash
rosrun rqt_reconfigure rqt_reconfigure

# mobile robotics framework 
roslaunch mr_local_planner planner.launch world:=line.world mode:=1
roslaunch mr_local_planner planner.launch stage:=1 world:=cave.world mode:=1

# simulation
roslaunch stage_ros world.launch world:=cave.world
roslaunch stage_ros world.launch world:=line.world

# control
rosrun teleop_twist_keyboard teleop_twist_keyboard.py

```
