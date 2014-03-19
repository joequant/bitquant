#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

echo "Content-type: text/html"
echo ""
echo "<pre>"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export HOME=/home/`whoami`
GIT_DIR=$HOME/git/bitquant

# Redirect STDERR to STDOUT
exec 2>&1

echo "Running from directory $GIT_DIR as user "`whoami`
echo "Installing packages"
. $GIT_DIR/web/install-build-deps.sh
echo "Doing initial installation"
. $GIT_DIR/git/bootstrap.sh
echo "Starting up servers"
sudo systemctl enable bitquant 2>&1 
sudo systemctl start bitquant 2>&1 
echo "(done)"
echo "</pre>"
