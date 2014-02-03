#!/bin/bash
# Execute as superuser
rmmod nbd
modprobe nbd max_part=16
qemu-nbd -c /dev/nbd0 $1
zerofree /dev/nbd0p1
qemu-nbd -d /dev/nbd0
