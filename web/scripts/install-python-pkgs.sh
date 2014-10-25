#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $SCRIPT_DIR > /dev/null
. norootcheck.sh
sudo /usr/share/bitquant/install-python-pkgs-sudo.sh $SCRIPT_DIR
popd
