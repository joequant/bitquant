#!/bin/bash
# Setup and configure website to use giving configuration

set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $SCRIPT_DIR > /dev/null
. rootcheck.sh
. configcheck.sh

pushd /var/www/html > /dev/null
rm -f *
for i in $SCRIPT_DIR/$config/*; do 
ln -s -f  ../../..$SCRIPT_DIR/$config/$(basename $i) $(basename $i)
done
popd > /dev/null

pushd /etc/httpd/conf/webapps.d > /dev/null
if [ -f 00_default_vhosts.conf ] ; then
mv -f 00_default_vhosts.conf 00_default_vhosts.conf.bak
fi
ln -s -f ../../../..$SCRIPT_DIR/00_bitquant.conf 00_bitquant.conf
popd > /dev/null
popd > /dev/null
