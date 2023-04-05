#!/bin/bash
set -e

# setup ros environment
unset ROS_DISTRO

echo "DYNAMIXEL PORT: ${DYNAMIXEL_PORT}"

if [ -f /sys/bus/usb-serial/devices/${DYNAMIXEL_PORT}/latency_timer ] && [ $(cat /sys/bus/usb-serial/devices/${DYNAMIXEL_PORT}/latency_timer) -ne 1 ]; then
  echo "Setting usb latency timer, requires sudo (use container password):"
  echo 1 | sudo tee /sys/bus/usb-serial/devices/${DYNAMIXEL_PORT}/latency_timer
fi

echo "USB LATENCY TIMER: $(cat /sys/bus/usb-serial/devices/${DYNAMIXEL_PORT}/latency_timer)"

exec "$@"
