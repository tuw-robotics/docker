# Noetic Iwos Core
registry.auto.tuwien.ac.at/roblab/docker/focal/noetic-iwos-robot

## useful commands:
```
tmux new-session \; split-window -h \; split-window -v \; attach \;
roslaunch tuw_iwos_launches robot.launch
roslaunch tuw_iwos_launches gamepad.launch
echo 1 | sudo tee /sys/bus/usb-serial/devices/ttyUSB0/latency_timer
```
To show this again run `hints` or `glow ~/entrypoint.md`.
