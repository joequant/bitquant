#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

echo "Content-type: text/html"
echo ""
echo "<pre>"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ME=`stat -c "%U" $SCRIPT_DIR/setup.sh`
GROUP=`stat -c "%G" $SCRIPT_DIR/setup.sh`
export HOME=/home/`whoami`
GIT_DIR=$HOME/git/bitquant

echo "Running from directory $GIT_DIR as user "`whoami`
echo "Installing packages"
. $GIT_DIR/web/install-build-deps.sh
echo "Doing initial installation"
. $GIT_DIR/git/bootstrap.sh
echo "(done)"
echo "</pre>"
