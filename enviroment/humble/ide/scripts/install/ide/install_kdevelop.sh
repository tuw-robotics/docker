#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install KDevelop"

apt-get install -y kdevelop
