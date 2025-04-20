sudo slcan_attach -f -s6 -o /dev/ttyACM1
sudo slcand -o -c -s6 /dev/ttyACM1 can0
sudo ip link set up can0
