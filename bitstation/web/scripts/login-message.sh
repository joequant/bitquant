#!/bin/bash

IPV4_ADDR=$(/sbin/ifconfig | grep "inet" | grep -v "inet6" | grep -v 10.0 | grep -v 127.0 | awk '{print $2;}' | sed -e 's/addr://' | head -1)
HOSTNAME=$(hostname)

echo "Connect with http://$IPV4_ADDR/"

