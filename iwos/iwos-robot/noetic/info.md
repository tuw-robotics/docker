# useful commands:
to reduce the dynamixel device  latency run the following command on the host device:
```bash
echo 1 | sudo tee /sys/bus/usb-serial/devices/ttyUSB0/latency_timer
```
create a tmux session with three terminal:
```bash
tmux new-session \; split-window -h \; split-window -v \; attach \;
```
run the iwos robot launch file:
```bash
roslaunch tuw_iwos_launches robot.launch rviz:=false
```
To show this again run `help`.
