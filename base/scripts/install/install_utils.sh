#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "install bash tools"

apt-get install -y     \
      cmake            \
      cmake-curses-gui \
      curl             \
      git              \
      gnupg2           \
      keychain         \
      myrepos          \
      nano             \
      python3          \
      python3-pip      \
      rsync            \
      tmux             \
      vim              \
      wget
