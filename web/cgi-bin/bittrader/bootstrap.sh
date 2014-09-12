#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

# would like to set -e, but this causes odd errors
# set -e

echo "Content-type: text/html"
echo ""
echo "<pre>"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPT_DIR/environment.sh

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
echo "Shutting down servers"
sudo systemctl stop bitquant
echo "Installing packages"
source $GIT_DIR/web/scripts/install-build-deps.sh
echo "Doing initial installation"
$GIT_DIR/git/bootstrap.sh
echo "Installing R packages"
$GIT_DIR/web/scripts/install-r-pkgs.sh
echo "Installing python packages"
$GIT_DIR/web/scripts/install-python-pkgs.sh

#set wiki conf
echo "Set up wiki"
./conf.sh /wiki-unlock
./conf.sh /wiki-init
echo "Set up ipython"
mkdir -p $MY_HOME/ipython
if [ -d $MY_HOME/ipython/examples ] ; then
mv $MY_HOME/ipython/examples $MY_HOME/ipython/examples.bak
fi
ln -s -f ../git/bitquant/web/home/ipython/examples $MY_HOME/ipython/examples
echo "Set up R"
mkdir -p $MY_HOME/R
cp -r $GIT_DIR/web/home/R/* $MY_HOME/R

# Refresh configurations
# This replaces the ajenti configuration with a 
# version that does not use ssl
./conf.sh /default-init

echo "Starting up servers"
$SCRIPT_DIR/servers.sh /on
touch $LOG_DIR/bootstrap.done
echo "(done)"
exec 1>&6
) 200> $LOG_DIR/bootstrap.lock &
echo "See progress in <a href='/cgi-bin/bittrader/log/bootstrap' target='_blank'>log file</a>" 
echo "</pre>"
