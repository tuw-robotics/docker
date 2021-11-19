#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install TurboVNC"
export TURBOVNC_VERSION="2.2.6"

apt install -y --no-install-recommends xubuntu-desktop wget
wget "https://sourceforge.net/projects/turbovnc/files/${TURBOVNC_VERSION}/turbovnc_${TURBOVNC_VERSION}_amd64.deb/download" -O /opt/turbovnc.deb
dpkg -i /opt/turbovnc.deb
rm -f /opt/turbovnc.deb
