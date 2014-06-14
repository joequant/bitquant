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
echo "Dumping OG data"
cp -r -p -a $GIT_DIR/OG-Platform/examples/examples-simulated/data og-data
echo "Dumping dokuwiki"
cp -r -p -a /var/lib/dokuwiki dokuwiki
rm -rf dokuwiki/cache/*
rm -rf dokuwiki/locks/*
echo "Dumping ipython"
cp -r -p -a $GIT_DIR/../ipython ipython
popd > /dev/null
tar cJf $MY_FILE.tar.xz bittrader
mv $MY_FILE.tar.xz $SCRIPT_DIR/../data
popd > /dev/null
rm -r $TMP_DIR/$$
