#!/bin/bash

npm install -g node-gyp coffeescript livescript
node-gyp -g install
# put yelp_uri in back to override downloaded version
npm install -g --unsafe ijavascript configurable-http-proxy solc jp-coffeescript jp-livescript modclean

# jupyter --version is breaking installs
# https://github.com/n-riesco/ijavascript/issues/200
ijsinstall --install=global
jp-coffee-install --install=global
jp-livescript-install --install=global

mkdir -p /usr/share/jupyter/kernels
mv /usr/local/share/jupyter/kernels/* /usr/share/jupyter/kernels

if [ -d /home/user/git/ethercalc ] ; then
    pushd /home/user/git/ethercalc
    npm i -g --unsafe ethercalc
    popd
fi
