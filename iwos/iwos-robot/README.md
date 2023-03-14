# tuw-iwos

This image is for the development of the IWOS robot.

The image can be build with or without cache:
- `make build`: build with cached docker images
- `make build_no_cache`: build without cached docker images

To build the image the source repositories have to be cloned:
```bash
make git_clone branch="<branch_name>" ws="<workspace ws00 or ws01>" repo="<repo>"
```
In case the source repositories are cloned already updated can be pulled with `make git_pull`.

After building the image is can be launched with `make run`.


## Image repository
The IWOS image is pushed to dockerhub in [this](https://hub.docker.com/repository/docker/ekrobotics/robotics) repository.
