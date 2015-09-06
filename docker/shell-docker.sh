#!/bin/bash
export LANG=C LC_ALL=C

if [ $# -ge 1 ]; then
IMAGE=$1
else 
IMAGE=$($SUDO docker ps | awk 'FNR==2 {print $NF}')
#IMAGE=bitstation
fi

exec $SUDO nsenter --target $($SUDO docker inspect --format {{.State.Pid}} $IMAGE) --mount --uts --ipc --net --pid
