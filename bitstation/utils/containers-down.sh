#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR=$SCRIPT_DIR/../config

cd $CONFIG_DIR
for f in *; do
    if [ -d "$f" ]; then
	docker-compose -f $f/docker-compose.yml down
    fi
done
