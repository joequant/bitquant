#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR=$SCRIPT_DIR/../config
LOG_DIR=$SCRIPT_DIR/../log
DATE=$(date -u +%Y%m%d%H%M%S)
CMD=$1
if [ -z $CMD ] ; then
    echo "no command"
    exit 1
fi

cd $CONFIG_DIR
if [ -z $2  ] ; then
    images=`echo */`
else
    images=$2
fi

if [ $CMD == "up" ] ; then
    for f in $images; do
	if [ -d "$f" ]; then
	    docker-compose -f $f/docker-compose.yml up > $LOG_DIR/`basename $f`.$DATE.log &
	fi
    done
elif [ $CMD == "down" ] ; then
    for f in $images; do
	if [ -d "$f" ]; then
	    docker-compose -f $f/docker-compose.yml down &
	fi
    done
    for job in `jobs -p` ; do
	echo $job
	wait $job || let "FAIL+=1"
    done
fi
