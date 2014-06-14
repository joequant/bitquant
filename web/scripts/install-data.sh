#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GIT_DIR=$SCRIPT_DIR/../../..
TMP_DIR=~/tmp
MY_FILE=bittrader-dump-`date -u +%Y%m%d-%H%M%S`
pushd $SCRIPT_DIR > /dev/null
. ../norootcheck.sh

echo "Install data"
mkdir -p $TMP_DIR/$$
popd > /dev/null
rm -r $TMP_DIR/$$
