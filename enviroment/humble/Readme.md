# Docker Humble
Details to the container images can be found in the Makefile's help.

## Build
```
make build
```

## Run
```
make run
```

### run-ide and run-gz
This targets are designed to run a container with some mounted folders.
- /home/robot
- /home/robot/.ssh
- /home/robot/.gitconfig 
- /home/robot/projects    (run-ide)
- /tmp/runtime-robot      (run-gz)

The local source folder are generated by the first start where you will be asked to execute a rsync command.
