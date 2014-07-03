#!/bin/bash 
# set setuid so that it is run with the user which checked out the
# orginal git

# would like to set -e, but this causes odd errors
# set -e

echo "Content-type: text/plain"
echo ""

TAG=init-data
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ME=`stat -c "%U" $SCRIPT_DIR/init-data.sh`
export MY_HOME=/home/$ME
GIT_DIR=$MY_HOME/git/bitquant
LOG_DIR=$GIT_DIR/web/log

if [ -e $LOG_DIR/$TAG.done ] ; then
rm -f $LOG_DIR/$TAG.done
rm -f $LOG_DIR/$TAG.log
fi

(
flock -x -n 200 || (echo "process already running" ; exit 1)
# Redirect STDERR to STDOUT
exec 6>&1
exec 2>&1

echo "Running from directory $GIT_DIR as user "`whoami`
echo "Shutting down servers"
sudo systemctl stop bitquant
echo "Doing init data"
$GIT_DIR/git/init-og.sh
mkdir -p $MY_HOME/ipython
cp -r $GIT_DIR/web/home/ipython/* $MY_HOME/ipython
mkdir -p $MY_HOME/R
cp -r $GIT_DIR/web/home/R/* $MY_HOME/R

echo "Starting up servers"
sudo systemctl start bitquant
touch $LOG_DIR/$TAG.done
echo "(done)"
) 200> $LOG_DIR/$TAG.lock

