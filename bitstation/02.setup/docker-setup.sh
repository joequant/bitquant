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
su user -p -c "/tmp/bootstrap.sh"

#set httpd
/usr/share/bitquant/conf.sh /httpd-lock

#set wiki conf
echo "Set up wiki"
/usr/share/bitquant/conf.sh /wiki-lock
/usr/share/bitquant/conf.sh /wiki-init

# Refresh configurations
/usr/share/bitquant/conf.sh /default-init

# set webmin
echo "Set up webmin"
/usr/share/bitquant/conf.sh /webmin-init
cat <<EOF > /etc/webmin/miniserv.users
user:x:0
EOF

grep ^root: /etc/webmin/webmin.acl | sed -e s/root:/user:/ >> /etc/webmin/webmin.acl

sed -i '/ipv6/d' /etc/mongod.conf
sed -i '/ipv6/d' /etc/mongos.conf
chmod a+rwx /srv
