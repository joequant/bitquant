#!/bin/bash

IMAGE=bitstation
if [ "$1" != "" ] ; then
   IMAGE=$1
fi

sudo docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -p 443:443 $IMAGE
