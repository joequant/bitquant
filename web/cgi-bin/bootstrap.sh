#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

echo "Content-type: text/plain"
echo ""
set -e
SCRIPT_DIR="$( cd "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd )"
echo "Running from directory $SCRIPT_DIR"
. $SCRIPT_DIR/../../git/bootstrap.sh
echo "(done)"
