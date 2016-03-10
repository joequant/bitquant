#!/bin/bash
export GOPATH=$HOME/golang
export WORKSPACE=$HOME/git
mkdir -p $GOPATH/src/github.com/openblockchain
pushd $GOPATH/src/github.com/openblockchain
git clone http://github.com/joequant/obc-peer.git
popd
pushd $WORKSPACE
git clone https://github.com/openblockchain/obc-dev-env.git
popd
