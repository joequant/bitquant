#!/bin/bash

#sudo modprobe nbd max_part=16
#sudo qemu-nbd -c /dev/nbd0 $1
#mkdir -p vdi
#sudo mount /dev/nbd0p1 vdi

mkdir -p disks
mkdir -p vdi
sudo vdfuse -f $1 disks
sudo mount disks/Partition1 vdi

