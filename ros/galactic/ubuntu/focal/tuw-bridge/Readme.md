# TUW ROS1_Bridge

## Information
This bridge enables the communication between ROS1 (noetic) and ROS2 (galactic) nodes, using custom messages.
The default build of this container runs all types of messages defined in the [tuw_msgs](https://github.com/tuw-robotics/tuw_msgs) repository.

## Building the container

In order to build this container open a terminal in the parent direcory and call:

``` bash
make build-tuw-bridge
```

## Running the bridge

The simplest way to run the bridge is by running th following command:

``` bash
docker run -it --name tuw-bridge --net=host registry.auto.tuwien.ac.at/roblab/docker/focal/galactic-tuw-bridge /bin/bash -c "ros2 run ros1_bridge dynamic_bridge"
```

This will start the container and connect it to the host network by the option ``--net=host``.
If the roscore is also connected to the host network or runs native, the bridge will find it and start transmitting messages between nodes of different ROS versions.
The dynamic bridge is the simplest one, for further information contact the [repository](https://github.com/ros2/ros1_bridge).

## Adding more custom messages

In order to add more custom message add the command to clone the repos in to the Dockerfile. After this line ``##### Add more custom messages here (ROS X) #####``.
If the messages have the same name in both versions no further configuration needs to be done. If not refer to the [documentation](https://github.com/ros2/ros1_bridge/blob/master/doc/index.rst#ros1_bridge) in order to specify a custom mapping rule.
