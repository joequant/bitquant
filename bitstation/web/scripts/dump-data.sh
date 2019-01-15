#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GIT_DIR=$SCRIPT_DIR/../../..
TMP_DIR=~/tmp
MY_FILE=bittrader-dump-`date -u +%Y%m%d-%H%M%S`
pushd $SCRIPT_DIR > /dev/null
. $SCRIPT_DIR/norootcheck.sh

echo "Dumping data"
mkdir -p $TMP_DIR/$$
pushd $TMP_DIR/$$ > /dev/null
mkdir -p bittrader
pushd bittrader > /dev/null
if [ -e $GIT_DIR/OG-Platform/examples/examples-simulated/data ] ; then
echo "Dumping OG data"
cp -r -p -a $GIT_DIR/OG-Platform/examples/examples-simulated/data og-data
fi

if [ -e /var/lib/dokuwiki ] ; then
echo "Dumping dokuwiki"
cp -r -p -a /var/lib/dokuwiki dokuwiki
rm -rf dokuwiki/cache/*
rm -rf dokuwiki/locks/*
fi

if [ -e $GIT_DIR/../ipython ] ; then
echo "Dumping ipython"
cp -r -p -a $GIT_DIR/../ipython ipython
fi

if [ -e $GIT_DIR/../irkernel ] ; then
echo "Dumping irkernel"
cp -r -p -a $GIT_DIR/../irkernel ikernel
fi

if [ -e $GIT_DIR/ethercalc/dump.json ] ; then
echo "Dumping ethercalc"
mkdir -p ethercalc
cp -r -p -a $GIT_DIR/ethercalc/dump.json ethercalc
fi

popd > /dev/null
echo "Generating tar file"
tar cJf $MY_FILE.tar.xz bittrader
mv $MY_FILE.tar.xz $SCRIPT_DIR/../data
popd > /dev/null
rm -r $TMP_DIR/$$
