#!/bin/bash

IMAGE=bitquant-web
if [ "$1" != "" ] ; then
   IMAGE=$1
fi

sudo docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v $HOME/git/bitquant:/home/user/git/bitquant \
-p 80:80 -p 443:443 $IMAGE
