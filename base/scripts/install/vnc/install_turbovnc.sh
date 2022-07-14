#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install TurboVNC"
export TURBOVNC_VERSION="2.2.6"

apt-get install -y --no-install-recommends xubuntu-desktop wget dbus-x11
wget "https://sourceforge.net/projects/turbovnc/files/${TURBOVNC_VERSION}/turbovnc_${TURBOVNC_VERSION}_amd64.deb/download" -O /opt/turbovnc.deb
dpkg -i /opt/turbovnc.deb
rm -f /opt/turbovnc.deb


cd ${MY_HOME}
mkdir ${MY_HOME}/.vnc
echo "#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
XDG_SESSION_TYPE=x11;  export XDG_SESSION_TYPE
exec /usr/bin/startxfce4

OS=`uname -s`" >> ${MY_HOME}/.vnc/xstartup.turbovnc
chmod +x ${MY_HOME}/.vnc/xstartup.turbovnc

# Remove keyboard shortcut to allow bash_completion in xfce4-terminal
echo "DISPLAY=:1 xfconf-query -c xfce4-keyboard-shortcuts -p \"/xfwm4/custom/<Super>Tab\" -r" >> ${MY_HOME}/.bashrc

echo "/opt/TurboVNC/bin/vncserver -kill :1" >> ${MY_HOME}/.bash_history
echo "/opt/TurboVNC/bin/vncserver -localhost -securitytypes NONE :1" >> ${MY_HOME}/.bash_history
