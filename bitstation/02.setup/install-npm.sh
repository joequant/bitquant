#!/bin/bash


pushd /home/user

#see https://github.com/npm/npm/issues/3565#issuecomment-202473011
# work around npm not working EPERM errors

echo "int chown() { return 0; }" > preload.c && gcc -shared -o preload.so preload.c 

npm install -g node-gyp coffeescript

# livescript
node-gyp -g install
# put yelp_uri in back to override downloaded version
LD_PRELOAD=/home/user/preload.so npm install -g --unsafe ijavascript configurable-http-proxy solc jp-coffeescript itypescript jp-babel modclean

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

if [ -d /home/user/git/ethercalc ] ; then
    pushd /home/user/git/ethercalc
    LD_PRELOAD=/home/user/preload.so npm i -g --unsafe ethercalc
    popd
fi
popd
