#!/bin/bash

cd $GOPATH/src/github.com/openblockchain/obc-peer
go build
./obc-peer
cd $GOPATH/src/github.com/openblockchain/obc-peer/openchain/container
go get .
go test -run BuildImage_Peer

docker run --rm -it -e OPENCHAIN_VM_ENDPOINT=http://172.17.0.1:4243 -e OPENCHAIN_PEER_ID=vp1 -e OPENCHAIN_PEER_ADDRESSAUTODETECT=true openchain-peer obc-peer peer
docker run --rm -it -e OPENCHAIN_VM_ENDPOINT=http://172.17.0.1:4243 -e OPENCHAIN_PEER_ID=vp2 -e OPENCHAIN_PEER_ADDRESSAUTODETECT=true -e OPENCHAIN_PEER_DISCOVERY_ROOTNODE=172.17.0.2:30303 openchain-peer obc-peer peer

cd $GOPATH/src/github.com/openblockchain/obc-peer
NAME=`OPENCHAIN_PEER_ADDRESS=172.17.0.2:30303 ./obc-peer chaincode deploy -u jim -p github.com/openblockchain/obc-peer/openchain/example/chaincode/chaincode_example02 -c '{"Function":"init", "Args": ["a","100", "b", "200"]}'`

OPENCHAIN_PEER_ADDRESS=172.17.0.2:30303 ./obc-peer chaincode invoke -n $NAME -c '{"Function": "invoke", "Args": ["a", "b", "10"]}'
OPENCHAIN_PEER_ADDRESS=172.17.0.2:30303 ./obc-peer chaincode query -l golang -n $NAME -c '{"Function": "query", "Args": ["a"]}'

