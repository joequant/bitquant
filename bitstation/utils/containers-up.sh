#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR=$SCRIPT_DIR/../config
LOG_DIR=$SCRIPT_DIR/../log
DATE=$(date -u +%Y%m%d%H%M%S)

cd $CONFIG_DIR
for f in *; do
    if [ -d "$f" ]; then
	docker-compose -f $f/docker-compose.yml up > $LOG_DIR/$f.$DATE.log &
    fi
done



