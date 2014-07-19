#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $SCRIPT_DIR > /dev/null
. norootcheck.sh
popd > /dev/null
sudo pip install --upgrade Quandl rpy2
