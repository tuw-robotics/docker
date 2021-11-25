#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install TurboVNC"

# Install libraries/dependencies
RUN apt-get install -y \
      openssh-server   \
      cmake            \
      vim              \
      wget             \
      tmux             \
      rsync            \
      curl             \
      git              \
      gnupg2
