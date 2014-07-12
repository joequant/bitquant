#!/bin/bash

# Modified to read in config file

if [ -e $HOME/bitquant.conf ] ;  then
echo "Reading configuration from $HOME/bitquant.conf"
. $HOME/bitquant.conf
else
echo "No configuration found.  Please install bitquant.conf.example"
fi

sudo rsync --numeric-ids -avzH vdi $FUSER@$FHOST:~/bitstation

