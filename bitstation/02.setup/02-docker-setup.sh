#!/bin/bash
set -e -v
echo "ZONE=UTC" > /etc/sysconfig/clock
export TZ="UTC"
# copy examples into /etc/skel
pushd /etc/skel > /dev/null
git clone --single-branch --depth 1 https://github.com/joequant/example-notebooks.git
popd > /dev/null

source /tmp/02-set-password.sh
pushd ~user > /dev/null
mkdir git
pushd git > /dev/null
git clone --single-branch --depth 1 https://github.com/joequant/bitquant.git
popd > /dev/null
chown -R user:user .
popd > /dev/null

WEB_DIR=/home/user/git/bitquant/bitstation/web
ME=user
GROUP=user

pushd $WEB_DIR > /dev/null

pushd /var/www/html > /dev/null
rm -f *
for i in index.html css data fonts js ; do
ln -s -f  ../../..$WEB_DIR/$i $i
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
mkdir -p /usr/share/bitquant
cp $WEB_DIR/cgi-bin/bittrader/environment.sh /usr/share/bitquant
cp $WEB_DIR/cgi-bin/bittrader/conf.sh /usr/share/bitquant
cp $WEB_DIR/cgi-bin/bittrader/timezone.sh /usr/share/bitquant
chown $ME:$GROUP /usr/share/bitquant/environment.sh
chmod o-w /usr/share/bitquant/*.sh
popd > /dev/null

echo "Doing initial installation"
pushd /var/lib
git clone --depth 1 https://github.com/joequant/etherpad-lite.git
popd
echo "Installing npm packages"
if [ -d /var/lib/etherpad-lite ] ; then
pushd /var/lib/etherpad-lite
make
if [ -d src/node_modules ] ; then
pushd src/node_modules
modclean -r
popd
fi
popd
fi
chown -R $ME:$GROUP /var/lib/etherpad-lite

#set httpd
/usr/share/bitquant/conf.sh /httpd-lock

#set wiki conf
echo "Set up wiki"
/usr/share/bitquant/conf.sh /wiki-lock
/usr/share/bitquant/conf.sh /wiki-init

# Refresh configurations
/usr/share/bitquant/conf.sh /default-init

# sed -i '/ipv6/d' /etc/mongod.conf
# sed -i '/ipv6/d' /etc/mongos.conf
chmod a+rwx /srv
