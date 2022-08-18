#!/bin/bash

su user -c "USER=user /opt/TurboVNC/bin/vncserver -localhost -verbose -nohttpd -depth 24 -geometry $RES -securitytypes NONE -name \"VNC\" :1" 
