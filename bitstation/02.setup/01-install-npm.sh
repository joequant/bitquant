#!/bin/bash

set -v
set +o errexit

source $rootfsDir/tmp/proxy.sh
npm install -g node-gyp coffeescript typescript

# livescript
node-gyp -g install
# put yelp_uri in back to override downloaded version
npm install -g --unsafe-perm=true ijavascript --zmq-external

# use git because of
# https://github.com/nearbydelta/itypescript/issues/20
npm install -g --unsafe-perm=true git+http://github.com/joequant/itypescript.git --zmq-external
npm install -g --unsafe-perm=true jp-coffeescript --zmq-external
npm install -g --unsafe-perm=true git+http://github.com/joequant/jp-livescript.git --zmq-external
npm install -g --unsafe-perm=true jp-babel --zmq-external
npm install -g --unsafe-perm=true configurable-http-proxy solc modclean

#jp-livescript

# jupyter --version is breaking installs
# https://github.com/n-riesco/ijavascript/issues/200
# fixed for all but livescript
# 
npm i -g --unsafe-perm=true ethercalc
pump --shutdown
