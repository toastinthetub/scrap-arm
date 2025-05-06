sudo slcan_attach -f -s6 -o /dev/ttyACM0
sudo slcand -o -c -s6 /dev/ttyACM0 can0
sudo ip link set up can0
