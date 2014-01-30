#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd /var/www/html
rm -f *
for i in $SCRIPT_DIR/bitquant/*; do 
echo $(basename $i)
sudo ln -s -f  ../../..$SCRIPT_DIR/bitquant/$(basename $i) $(basename $i)
done
popd

pushd /etc/httpd/conf/webapps.d
sudo mv -f 00_default_vhosts.conf 00_default_vhosts.conf.bak
sudo ln -s -f ../../../..$SCRIPT_DIR/00_bitquant.conf 00_bitquant.conf
popd

if [ -d ../../OG-Platform ] ; then
pushd ../../OG-Platform/examples/examples-bitquant/
mvn install
mvn opengamma:server-init -Dconfig=fullstack
popd
fi

