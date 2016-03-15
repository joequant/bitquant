#!/bin/bash
cd $GOPATH/src/github.com/openblockchain/obc-peer
NAME=`OPENCHAIN_PEER_ADDRESS=172.17.0.2:30303 ./obc-peer chaincode deploy -p github.com/openblockchain/obc-peer/openchain/example/chaincode/chaincode_example02 -c '{"Function":"init", "Args": ["a","100", "b", "200"]}'`

OPENCHAIN_PEER_ADDRESS=172.17.0.2:30303 ./obc-peer chaincode invoke -n $NAME -c '{"Function": "invoke", "Args": ["a", "b", "10"]}'
OPENCHAIN_PEER_ADDRESS=172.17.0.2:30303 ./obc-peer chaincode query -l golang -n $NAME -c '{"Function": "query", "Args": ["a"]}'
