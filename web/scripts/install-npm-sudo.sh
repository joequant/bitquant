#!/bin/bash
# sudo portion of npm package installations

echo "Running npm root installation"
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $ROOT_SCRIPT_DIR/rootcheck.sh
SCRIPT_DIR=$1
ME=$2

npm install -g node-gyp
node-gyp -g install
# put yelp_uri in back to override downloaded version
for repo in webpack ijavascript configurable-http-proxy ; do
npm install -g --unsafe $repo
done
ijsinstall --install=global

pushd /home/$ME/git/ethercalc
npm i -g --unsafe ethercalc
popd
