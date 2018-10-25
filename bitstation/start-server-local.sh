#!/bin/bash

IMAGE=joequant/bitstation
if [ "$1" != "" ] ; then
   IMAGE=$1
fi

sudo docker run --privileged -p 80:80 -p 443:443 $IMAGE
