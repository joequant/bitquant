#!/bin/bash
MY_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_DIR=$1
ME=$2
GROUP=$3
ATTIC_DIR=$4
GIT_DIR=$SCRIPT_DIR/../../..

TMP_DIR=~/tmp
. $SCRIPT_DIR/rootcheck.sh

set -e
pushd $SCRIPT_DIR > /dev/null
pushd bittrader > /dev/null

#echo "Loading OG data"
#sudo chown $ME:$GROUP -R $GIT_DIR/OG-Platform/examples/examples-simulated/data


if [ -e /var/lib/dokuwiki ] ; then
echo "Loading dokuwiki"
mv /var/lib/dokuwiki $ATTIC_DIR
fi
mv dokuwiki /var/lib
chown apache:apache -R  /var/lib/dokuwiki

if [ -e $GIT_DIR/../ipython ] ; then
echo "Loading ipython"
mv $GIT_DIR/../ipython $ATTIC_DIR
fi
mv ipython $GIT_DIR/..
chown -R $ME:$GROUP $GIT_DIR/../ipython 

if [ -e $GIT_DIR/../irkernel ] ; then
echo "Loading irkernel"
mv $GIT_DIR/../irkernel $ATTIC_DIR
fi
mv irkernel $GIT_DIR/..
chown -R $ME:$GROUP $GIT_DIR/../irkernel 

#if [ -d $GIT_DIR/ethercalc ] ; then
#echo "Loading ethercalc"
#mkdir -p $ATTIC_DIR/ethercalc
#mv $GIT_DIR/ethercalc/dump.json $ATTIC_DIR/ethercalc
#mv ethercalc/dump.json $GIT_DIR/ethercalc
#chown $ME:$GROUP $GIT_DIR/ethercalc/dump.json
#fi
popd > /dev/null
rm -r $TMP_DIR/$$
popd > /dev/null
