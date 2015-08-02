#!/bin/bash
# sudo portion of python package installations

echo "Running python installation"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ME=`stat -c "%U" $SCRIPT_DIR/install-r-pkgs.sh`

pushd $SCRIPT_DIR > /dev/null
. norootcheck.sh
sudo /usr/share/bitquant/install-python-sudo.sh $SCRIPT_DIR $ME
popd > /dev/null




