#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

echo "Content-type: text/html"
echo ""
echo "<pre>"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export HOME=/home/`whoami`
GIT_DIR=$HOME/git/bitquant
LOG_DIR=$GIT_DIR/web/log

(
flock -x -n 200 || exit 1
# Redirect STDERR to STDOUT
echo "Saving to <a href='log/bootstrap.log' target='_blank'>log file</a>"
rm -f $LOG_DIR/bootstrap.log
exec 6>&1
exec > $LOG_DIR/bootstrap.log
exec 2>&1

echo "Running from directory $GIT_DIR as user "`whoami`
echo "Installing packages"
$GIT_DIR/web/install-build-deps.sh
echo "Doing initial installation"
$GIT_DIR/git/bootstrap.sh
echo "Starting up servers"
sudo systemctl enable bitquant
sudo systemctl start bitquant
echo "(done)"
exec 1>&6
) 200> $LOG_DIR/bootstrap.lock &
echo "See progress in <a href='log/bootstrap.log' target='_blank'>log file</a>" 
echo "</pre>"
