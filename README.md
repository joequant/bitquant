Bitquant
=================

Scripts and installation routines for Bitquant Research Laboratories
(Asia) Ltd.

In addition to paper drafts, this repository contains the script to
generate the diskimage for the bitstation trading system as well as a
docker image.

Bitstation consists of a disk image which can be run in VirtualBox or
uploaded to a cloud computing system.

Docker image creation is in docker

Smart Contract
==============

Smart contract is available at 

http://github.com/joequant/bitquant/tree/master/smart-contracts

Creating trading platform
=========================

cd docker
make

This will create a local docker image with bitstation.  Running the
system with the including scripts will run that image on port 80


