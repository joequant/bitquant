#!/bin/bash
export LANG=C LC_ALL=C

sudo echo

if [ $# -ge 1 ]; then
IMAGE=$1
else 
IMAGE=`sudo docker ps | awk 'FNR==2 {print $NF}'`
fi

exec sudo docker stop $IMAGE

