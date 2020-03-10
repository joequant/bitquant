#!/bin/bash -v
# Setup and configure website to use giving configuration

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_DIR=$SCRIPT_DIR/..

# use ls because stat causes error on dockerhub
ME=$(ls -ld $SCRIPT_DIR/setup.sh | awk '{print $3}')
GROUP=$(ls -ld $SCRIPT_DIR/setup.sh | awk '{print $4}')

pushd $SCRIPT_DIR > /dev/null

pushd /var/www/html > /dev/null
rm -f *
for i in $WEB_DIR/bitstation/*; do
ln -s -f  ../../..$WEB_DIR/bitstation/$(basename $i) $(basename $i)
done
popd > /dev/null

# Do a special copy so that suexec works
pushd /var/www/cgi-bin > /dev/null
rm -rf /var/www/cgi-bin/*
for i in $WEB_DIR/cgi-bin/*; do
cp -r ../../..$WEB_DIR/cgi-bin/$(basename $i) $(basename $i)
chown -R $ME:$GROUP $(basename $i)
done
popd > /dev/null

pushd /etc/httpd/conf/webapps.d > /dev/null
if [ -f 00_default_vhosts.conf ] ; then
mv -f 00_default_vhosts.conf 00_default_vhosts.conf.bak
fi
popd > /dev/null

# Create root copy of scripts
rm -rf /usr/share/bitquant
mkdir -p /usr/share/bitquant
cp $WEB_DIR/scripts/*-sudo.sh /usr/share/bitquant
cp $WEB_DIR/scripts/*root*.sh /usr/share/bitquant
cp $WEB_DIR/scripts/environment.sh /usr/share/bitquant
cp $WEB_DIR/cgi-bin/bittrader/conf.sh /usr/share/bitquant
cp $WEB_DIR/cgi-bin/bittrader/timezone.sh /usr/share/bitquant
chown $ME:$GROUP /usr/share/bitquant/environment.sh
chmod o-w /usr/share/bitquant/*.sh

#systemctl daemon-reload
#systemctl enable bitquant
#systemctl restart bitquant
#systemctl reload httpd
