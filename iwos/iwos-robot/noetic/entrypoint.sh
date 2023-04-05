#!/bin/bash
set -e

# setup ros environment
unset ROS_DISTRO

device=$(ls -l /dev/dynamixel | awk '{print $NF}')
echo $device

if [ -f /sys/bus/usb-serial/devices/$device/latency_timer ] && [ $(cat /sys/bus/usb-serial/devices/$device/latency_timer) -ne 1 ]; then
  echo "Setting usb latency timer, requires sudo (use container password):"
  echo 1 | sudo tee /sys/bus/usb-serial/devices/$device/latency_timer
fi

echo "USB LATENCY TIMER: $(cat /sys/bus/usb-serial/devices/$device/latency_timer)"

exec "$@"
