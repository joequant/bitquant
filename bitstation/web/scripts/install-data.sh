#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GIT_DIR=$SCRIPT_DIR/../../..
ME=`stat -c "%U" $SCRIPT_DIR/install-data.sh`
GROUP=`stat -c "%G" $SCRIPT_DIR/install-data.sh`

TMP_DIR=~/tmp
MY_FILE=$(readlink -e $1)

set -e
pushd $SCRIPT_DIR > /dev/null
. $SCRIPT_DIR/norootcheck.sh

echo "Install data"
mkdir -p $TMP_DIR/$$
cd $TMP_DIR/$$
ATTIC_DIR=~/attic/$$
mkdir -p $ATTIC_DIR

tar xJf $MY_FILE
if [ ! -e "bittrader" ] ; then
echo "not dump file"
exit 1
fi

sudo /usr/share/bitquant/install-data-sudo.sh $SCRIPT_DIR $ME $GROUP $ATTIC_DIR
