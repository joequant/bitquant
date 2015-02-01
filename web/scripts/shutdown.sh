#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
. norootcheck.sh
# don't shutdown web service
#sudo systemctl stop httpd
#ipython notebook &

killall ServiceRunner
killall java-abrt
killall node
killall ipython
killall ipython3




