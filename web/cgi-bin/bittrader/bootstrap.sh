#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

echo "Content-type: text/plain"
echo ""
set -e
SCRIPT_DIR=%SCRIPT_DIR%
echo "Running from directory $SCRIPT_DIR as user "`whoami`
. $SCRIPT_DIR/../git/bootstrap.sh

echo "(done)"
