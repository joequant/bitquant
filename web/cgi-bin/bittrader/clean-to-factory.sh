#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

echo "Content-type: text/html"
echo ""
echo "<pre>"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export HOME=/home/`whoami`
GIT_DIR=$HOME/git/bitquant

echo "Running from directory $GIT_DIR as user "`whoami`
echo "Cleaning to factory"
. $GIT_DIR/git/clean-to-factory.sh
echo "</pre>"
