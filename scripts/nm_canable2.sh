#!/bin/bash

# required packages
REQUIRED_PACKAGES=("can-utils")

# check if required packages are installed
for package in "${REQUIRED_PACKAGES[@]}"; do
  dpkg -l | grep -qw "$package" || echo -e "\033[31mwarning: package '$package' missing\033[0m"
done

# check if slcan0 already exists and is up
if ip link show slcan0 2>/dev/null | grep -q "UP"; then
  echo "slcan0 already running"
  exit 0
fi

# kill leftover slcand stuff
sudo pkill slcand 2>/dev/null

# bring slcan0 down if it's stuck
sudo ip link set down slcan0 2>/dev/null
sudo slcan_detach slcan0 2>/dev/null

# check for device
if [ ! -e /dev/ttyACM1 ]; then
  echo -e "\033[31merror: /dev/ttyACM1 not found\033[0m"
  exit 1
fi

# attach canable to slcan0
echo "attaching /dev/ttyACM0 to slcan0"
sudo slcan_attach -f -s8 -o /dev/ttyACM1

# bring interface up
echo "bringing up slcan0"
sudo ip link set up slcan0

# verify it's up
if ip link show slcan0 | grep -q "UP"; then
  echo "slcan0 setup complete"
else
  echo -e "\033[31merror: slcan0 failed to start\033[0m"
  exit 1
fi
