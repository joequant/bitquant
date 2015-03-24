#!/bin/bash
# Setup and configure website to use giving configuration

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_DIR=$SCRIPT_DIR/..
ME=`stat -c "%U" $SCRIPT_DIR/setup.sh`
GROUP=`stat -c "%G" $SCRIPT_DIR/setup.sh`

pushd $SCRIPT_DIR > /dev/null
. rootcheck.sh
. configcheck.sh

urpmi.addmedia "Bitquant sourceforge" https://sourceforge.net/projects/bitquant/files/rpms/`uname -m`/

pushd /var/www/html > /dev/null
rm -f *
for i in $WEB_DIR/$config/*; do 
ln -s -f  ../../..$WEB_DIR/$config/$(basename $i) $(basename $i)
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
cp $WEB_DIR/scripts/install-build-deps.sh /usr/share/bitquant
cp $WEB_DIR/scripts/*root*.sh /usr/share/bitquant
cp $WEB_DIR/scripts/environment.sh /usr/share/bitquant
cp $WEB_DIR/cgi-bin/bittrader/conf.sh /usr/share/bitquant
cp $WEB_DIR/cgi-bin/bittrader/timezone.sh /usr/share/bitquant
chown $ME:$GROUP /usr/share/bitquant/environment.sh
chmod o-w /usr/share/bitquant/*.sh

$WEB_DIR/cgi-bin/bittrader/conf.sh /default-init

systemctl daemon-reload
systemctl enable httpd
systemctl restart httpd
