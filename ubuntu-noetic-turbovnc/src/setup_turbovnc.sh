#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Setup TurboVNC for a user"


mkdir ~/.vnc
echo "#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
XDG_SESSION_TYPE=x11;  export XDG_SESSION_TYPE
exec /usr/bin/startxfce4

OS=`uname -s`" >> ~/.vnc/xstartup.turbovnc

# Remove keyboard shortcut to allow bash_completion in xfce4-terminal
echo "DISPLAY=:1 xfconf-query -c xfce4-keyboard-shortcuts -p \"/xfwm4/custom/<Super>Tab\" -r" >> ~/.bashrc

echo "/opt/TurboVNC/bin/vncserver -kill :1" >> ~/.bash_history
echo "/opt/TurboVNC/bin/vncserver -localhost -securitytypes NONE :1" >> ~/.bash_history
