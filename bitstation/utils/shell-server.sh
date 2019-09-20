#!/bin/bash
export LANG=C LC_ALL=C

if [ $# -ge 1 ]; then
    IMAGE=$($SUDO docker ps | tail -n +2 | grep $1 | awk '{print $NF}' )
    echo $IMAGE
else 
    IMAGE=$($SUDO docker ps | awk 'FNR==2 {print $NF}')
fi

if [ $# -ge 2 ]; then
    CMD=$2
else
    CMD=/bin/bash
fi

exec $SUDO docker exec -it $IMAGE $CMD
