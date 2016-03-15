#!/bin/bash
export GOPATH=$HOME/golang
mkdir -p $GOPATH/src/github.com/openblockchain
pushd $GOPATH/src/github.com/openblockchain > /dev/null
git clone http://github.com/joequant/obc-peer.git
pushd obc-peer > /dev/null
git pull
popd > /dev/null
popd > /dev/null

git clone https://github.com/joequant/obc-dev-env.git
pushd obc-dev-env > /dev/null
git pull
vagrant up
vagrant ssh -c /openchain/build-scripts/devbuild.sh
popd > /dev/null
