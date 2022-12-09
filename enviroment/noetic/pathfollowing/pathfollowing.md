# Pathfollowing
## requirments
* The robot must listen __and__ publish __/tuw_nav_msgs/JointIWS__ messages.
* The robot should not publish its odometry. The tuw_control node will compute and publish the odometry on __odom__

## Commands for __GazeboSim__:
It makes sens to connect another bash to the container and to start the simulation before you run the path following.e

```
docker exec -it $HOSTNAME-pathfollowing bash -c 'cd $HOME/projects/ros/gazebo; exec "${SHELL:-sh}"'
roslaunch tuw_gazebo_models robot_in_world.launch motor_plugin:=diff_iws launch_ground_truth_robot_state_publisher:=false
roslaunch tuw_launches laser_filter.launch robot_name:=r0 # if needed
```

## Commands for __pathfollowing__:
```
# with AMCL
roslaunch tuw_launches pathfollowing.launch

# without AMCL
roslaunch tuw_launches pathfollowing.launch launch_localization:=false
rosrun fake_localization fake_localization base_pose_ground_truth:=/r0/ground_truth/odom   amcl_pose:=/r0/localization/pose _odom_frame_id=fake_odom

roslaunch tuw_launches rviz_pathfollowing.launch
tmux new -s pathfollowing \; split-window -v \; select-pane -t 1 \; split-window -v \; select-pane -t 0 \; attach
```
