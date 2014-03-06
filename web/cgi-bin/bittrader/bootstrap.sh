#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

echo "Content-type: text/html"
echo ""
echo "<pre>"
SCRIPT_DIR=%SCRIPT_DIR%
export HOME=/home/`whoami`
echo "Running from directory $SCRIPT_DIR as user "`whoami`
echo "Installing packages"
. $SCRIPT_DIR/../rpm/install-build-deps.sh
echo "Doing initial installation"
. $SCRIPT_DIR/../git/bootstrap.sh
echo "(done)"
echo "</pre>"
