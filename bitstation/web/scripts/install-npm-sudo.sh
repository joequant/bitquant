#!/bin/bash
# sudo portion of npm package installations

set -v
echo "Running npm root installation"
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $ROOT_SCRIPT_DIR/rootcheck.sh
SCRIPT_DIR=$1
ME=$2

npm install -g node-gyp coffeescript livescript
node-gyp -g install
# put yelp_uri in back to override downloaded version
npm install -g --unsafe ijavascript configurable-http-proxy solc jp-coffeescript jp-livescript modclean
ijsinstall --install=global
jp-coffee-install --install=global
jp-livescript-install --install=global
mkdir -p /usr/share/jupyter/kernels
mv /usr/local/share/jupyter/kernels/* /usr/share/jupyter/kernels

pushd /home/$ME/git/ethercalc
npm i -g --unsafe ethercalc
popd

pushd /usr/lib/node_modules
modclean -r
popd
