#!/bin/bash
# sudo portion of npm package installations

set -v
echo "Running npm root installation"
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $ROOT_SCRIPT_DIR/rootcheck.sh
SCRIPT_DIR=$1
ME=$2

pushd /home/$ME/git/ethercalc
npm i -g --unsafe ethercalc
popd

#pushd /usr/lib/node_modules
#modclean -r
#popd
