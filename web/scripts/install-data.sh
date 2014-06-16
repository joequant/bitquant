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

tar xJf $MY_FILE
if [ ! -e "bittrader" ] ; then
echo "not dump file"
exit 1
fi
pushd bittrader > /dev/null
echo "Loading"
if [ -e $GIT_DIR/OG-Platform/examples/examples-simulated/data ] ; then
mv $GIT_DIR/OG-Platform/examples/examples-simulated/data \
   $GIT_DIR/OG-Platform/examples/examples-simulated/data.$$.bak
fi

echo "Loading OG data"
mv og-data $GIT_DIR/OG-Platform/examples/examples-simulated/data
sudo chown $ME:$GROUP -R $GIT_DIR/OG-Platform/examples/examples-simulated/data

echo "Loading dokuwiki"
if [ -e /var/lib/dokuwiki ] ; then
sudo mv /var/lib/dokuwiki  /var/lib/dokuwiki.$$.bak
fi
sudo mv dokuwiki /var/lib
sudo chown apache:apache -R  /var/lib/dokuwiki

echo "Loading ipython"
if [ -e $GIT_DIR/../ipython ] ; then
sudo mv $GIT_DIR/../ipython $GIT_DIR/../ipython.$$.bak
fi

mv ipython $GIT_DIR/..
sudo chown -R $ME:$GROUP $GIT_DIR/../ipython 
popd > /dev/null
rm -r $TMP_DIR/$$
popd > /dev/null
