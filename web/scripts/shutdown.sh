#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
. norootcheck.sh

function killmatch {
for KILLPID in `ps ax | grep -v grep | grep $1 | awk '{ print $1;}'`
do 
  echo "killing $1 $KILLPID"
  kill -9 $KILLPID
done
}

# don't shutdown web service
#sudo systemctl stop httpd
#ipython notebook &

killmatch ServiceRunner
killmatch java-abrt
killmatch rkernel
killmatch ipython3
killmatch ipython
killmatch ethercalc
killmatch dynamic-reverse-proxy






