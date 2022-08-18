# ros1 desktop
# created by Markus Bader <markus.bader@tuwien.ac.at>
# based on the https://github.com/osrf/docker_images

ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/focal
ARG BASE_CONTAINER=$OWNER/noetic-base
FROM $BASE_CONTAINER

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-desktop=1.5.0-1* \
    && rm -rf /var/lib/apt/lists/*

