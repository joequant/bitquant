#!/bin/bash
# Execute as superuser
sudo rmmod nbd
sudo modprobe nbd max_part=16
sudo qemu-nbd -c /dev/nbd0 $1
sudo zerofree /dev/nbd0p1
sudo qemu-nbd -d /dev/nbd0
