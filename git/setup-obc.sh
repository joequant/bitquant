#!/bin/bash
export GOPATH=$HOME/golang
mkdir -p $GOPATH/src/github.com/openblockchain
pushd $GOPATH/src/github.com/openblockchain
git clone http://github.com/joequant/obc-peer.git
popd

git clone https://github.com/openblockchain/obc-dev-env.git
pushd obc-dev-env
vagrant up
popd
