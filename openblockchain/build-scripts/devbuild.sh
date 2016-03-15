#!/bin/bash

cd $GOPATH/src/github.com/openblockchain/obc-peer
go build
cd $GOPATH/src/github.com/openblockchain/obc-peer/openchain/container
go get .
go test -run BuildImage_Peer -timeout 99999s

