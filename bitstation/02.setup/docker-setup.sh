#!/bin/bash
set -e -v
echo "ZONE=UTC" > /etc/sysconfig/clock
export TZ="UTC"
# user account may already exist
useradd user || true
chmod a+rx ~user
echo 'cubswin:)' | passwd user --stdin
echo 'cubswin:)' | passwd root --stdin
cd ~user
mkdir git
cd git
git clone --single-branch --depth 1 https://github.com/joequant/bitquant.git
chown -R user:user .
. /tmp/setup.sh

#set httpd
/usr/share/bitquant/conf.sh /httpd-lock

#set wiki conf
echo "Set up wiki"
/usr/share/bitquant/conf.sh /wiki-lock
/usr/share/bitquant/conf.sh /wiki-init

# Refresh configurations
/usr/share/bitquant/conf.sh /default-init

sed -i '/ipv6/d' /etc/mongod.conf
sed -i '/ipv6/d' /etc/mongos.conf
chmod a+rwx /srv
