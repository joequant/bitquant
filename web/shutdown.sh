#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. norootcheck.sh
# don't shutdown web service
#sudo systemctl stop httpd
#ipython notebook &

killall ServiceRunner
killall java
killall node
killall ipython



