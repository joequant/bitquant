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

pushd bittrader > /dev/null
echo "Loading data"
if [ -e $GIT_DIR/OG-Platform/examples/examples-simulated/data ] ; then
mv $GIT_DIR/OG-Platform/examples/examples-simulated/data \
   $ATTIC_DIR/og-data
fi

echo "Loading OG data"
mv og-data $GIT_DIR/OG-Platform/examples/examples-simulated/data
sudo chown $ME:$GROUP -R $GIT_DIR/OG-Platform/examples/examples-simulated/data


if [ -e /var/lib/dokuwiki ] ; then
echo "Loading dokuwiki"
sudo mv /var/lib/dokuwiki $ATTIC_DIR
fi
sudo mv dokuwiki /var/lib
sudo chown apache:apache -R  /var/lib/dokuwiki

if [ -e $GIT_DIR/../ipython ] ; then
echo "Loading ipython"
sudo mv $GIT_DIR/../ipython $ATTIC_DIR
fi
mv ipython $GIT_DIR/..
sudo chown -R $ME:$GROUP $GIT_DIR/../ipython 


if [ -d $GIT_DIR/ethercalc ] ; then
echo "Loading ethercalc"
mkdir -p $ATTIC_DIR/ethercalc
mv $GIT_DIR/ethercalc/dump.json $ATTIC_DIR/ethercalc
sudo mv ethercalc/dump.json $GIT_DIR/ethercalc
sudo chown $ME:$GROUP $GIT_DIR/ethercalc/dump.json
fi
popd > /dev/null
rm -r $TMP_DIR/$$
popd > /dev/null
