#!/bin/bash

set -v

pushd /home/user

npm install -g node-gyp coffeescript

# livescript
node-gyp -g install
# put yelp_uri in back to override downloaded version
npm install -g --unsafe-perm=true ijavascript --zmq-external
npm install -g --unsafe-perm=true itypescript --zmq-external
npm install -g --unsafe-perm=true jp-coffeescript --zmq-external
npm install -g --unsafe-perm=true jp-babel --zmq-external
npm install -g --unsafe-perm=true configurable-http-proxy solc modclean

#jp-livescript

# jupyter --version is breaking installs
# https://github.com/n-riesco/ijavascript/issues/200
# fixed for all but livescript
# jp-livescript-install --install=global

ijsinstall --install=global
its --install=global
jp-coffee-install --install=global
jp-babel-install --install=global

mkdir -p /usr/share/jupyter/kernels
mv /usr/local/share/jupyter/kernels/* /usr/share/jupyter/kernels

npm i -g --unsafe-perm=true ethercalc

popd
