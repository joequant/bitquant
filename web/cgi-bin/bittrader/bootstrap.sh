#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

# would like to set -e, but this causes odd errors
# set -e

echo "Content-type: text/html"
echo ""
echo "<pre>"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export HOME=/home/`whoami`
GIT_DIR=$HOME/git/bitquant
LOG_DIR=$GIT_DIR/web/log

if [ -e $LOG_DIR/bootstrap.done ] ; then
rm -f $LOG_DIR/bootstrap.done
rm -f $LOG_DIR/bootstrap.log
fi

(
flock -x -n 200 || exit 1
# Redirect STDERR to STDOUT
echo "Saving to <a href='/cgi-bin/bittrader/log/bootstrap' target='_blank'>log file</a>"
exec 6>&1
exec > $LOG_DIR/bootstrap.log
exec 2>&1

echo "Running from directory $GIT_DIR as user "`whoami`
echo "Installing packages"
source $GIT_DIR/web/install-build-deps.sh
echo "Doing initial installation"
$GIT_DIR/git/bootstrap.sh
echo "Starting up servers"
sudo systemctl enable bitquant
sudo systemctl start bitquant
touch $LOG_DIR/bootstrap.done
echo "(done)"
exec 1>&6
) 200> $LOG_DIR/bootstrap.lock &
echo "See progress in <a href='/cgi-bin/bittrader/log/bootstrap' target='_blank'>log file</a>" 
echo "</pre>"
