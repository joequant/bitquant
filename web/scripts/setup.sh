#!/bin/bash
# Setup and configure website to use giving configuration

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_DIR=$SCRIPT_DIR/..
ME=`stat -c "%U" $SCRIPT_DIR/setup.sh`
GROUP=`stat -c "%G" $SCRIPT_DIR/setup.sh`

pushd $SCRIPT_DIR > /dev/null
. rootcheck.sh
. configcheck.sh

pushd /var/www/html > /dev/null
rm -f *
for i in $WEB_DIR/$config/*; do 
ln -s -f  ../../..$WEB_DIR/$config/$(basename $i) $(basename $i)
done
popd > /dev/null

pushd /etc/httpd/conf/webapps.d > /dev/null
if [ -f 00_default_vhosts.conf ] ; then
mv -f 00_default_vhosts.conf 00_default_vhosts.conf.bak
fi
popd > /dev/null

$WEB_DIR/cgi-bin/bittrader/conf.sh /default-init

systemctl daemon-reload
systemctl enable httpd
systemctl restart httpd
systemctl enable bitquant-flask
systemctl restart bitquant-flask
