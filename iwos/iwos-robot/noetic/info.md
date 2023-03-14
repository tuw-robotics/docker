# useful commands:
create a tmux session with three terminal
```bash
tmux new-session \; split-window -h \; split-window -v \; attach \;
```
run the iwos robot launch file
```bash
roslaunch tuw_iwos_launches robot.launch gamepad:=true laser:=true
```
To show this again run `hints`.
