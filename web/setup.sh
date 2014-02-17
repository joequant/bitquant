#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd /var/www/html
rm -f *
for i in $SCRIPT_DIR/bitquant/*; do 
ln -s -f  ../../..$SCRIPT_DIR/bitquant/$(basename $i) $(basename $i)
done
popd

pushd /etc/httpd/conf/webapps.d
if [ -f 00_default_vhosts.conf ] ; then
mv -f 00_default_vhosts.conf 00_default_vhosts.conf.bak
fi
ln -s -f ../../../..$SCRIPT_DIR/00_bitquant.conf 00_bitquant.conf
popd

