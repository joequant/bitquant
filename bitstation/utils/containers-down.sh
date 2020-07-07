#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR=$SCRIPT_DIR/../config

cd $CONFIG_DIR
if [ -z $1  ] ; then
    images=`echo */`
else
    images=$1
fi
for f in $images; do
    if [ -d "$f" ]; then
	docker-compose -f $f/docker-compose.yml down &
    fi
done
for job in `jobs -p`
do
echo $job
    wait $job || let "FAIL+=1"
done
