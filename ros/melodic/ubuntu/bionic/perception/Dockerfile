# ros1 perception
# created by Markus Bader <markus.bader@tuwien.ac.at>
# based on the https://github.com/osrf/docker_images

ARG OWNER=registry.auto.tuwien.ac.at/roblab/docker/bionic
ARG BASE_CONTAINER=$OWNER/melodic-base
FROM $BASE_CONTAINER

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-perception=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

