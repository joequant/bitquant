#!/bin/bash

export MYDIR=`pwd`
cd $GOPATH/src/github.com/openblockchain/obc-peer/openchain/container
docker run --rm -t -e OPENCHAIN_VM_ENDPOINT=http://172.17.0.1:4243 -e OPENCHAIN_PEER_ID=vp1 -e OPENCHAIN_PEER_ADDRESSAUTODETECT=true openchain-peer obc-peer peer >& $MYDIR/vp1.log &
docker run --rm -t -e OPENCHAIN_VM_ENDPOINT=http://172.17.0.1:4243 -e OPENCHAIN_PEER_ID=vp2 -e OPENCHAIN_PEER_ADDRESSAUTODETECT=true -e OPENCHAIN_PEER_DISCOVERY_ROOTNODE=172.17.0.2:30303 openchain-peer obc-peer peer >& $MYDIR/vp2.log &


