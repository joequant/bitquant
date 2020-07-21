#!/bin/bash
echo "starting"

mkdir -p /var/spool/squid
chown -R squid:squid /var/spool/squid
chown -R squid:squid /var/log/squid
touch /var/log/squid/squid.log
chmod a+rw /var/log/squid/squid.log

if [ ! -d /var/spool/squid/00 ]; then
    /sbin/squid -z -F --foreground >> /var/log/squid/squid.log 2>&1
fi

/sbin/squid -N >> /var/log/squid/squid.log 2>&1 &

mkdir -p /var/spool/ccache
chmod -R a+rwx /var/spool/ccache
export CCACHE_DIR=/var/spool/ccache
export PATH=/usr/lib64/ccache/bin:/usr/bin
export DISTCC_CMDLIST=/etc/sysconfig/distccd-cmdlist

touch /var/log/distccd.log
chmod a+rw /var/log/distccd.log
/usr/bin/distccd --verbose --allow 172.0.0.0/24 --allow 192.168.0.0/16 --allow 127.0.0.1 --allow 10.0.0.0/24 --stats --log-file /var/log/distccd.log

if [ ! -d /var/spool/devpi ]; then
    mkdir -p /var/spool/devpi
    touch /var/log/devpi-server.log
    devpi-init --serverdir /var/spool/devpi
fi
chmod a+rw /var/log/devpi-server.log
chmod -R a+rw /var/spool/devpi
su nobody -c "devpi-server --serverdir /var/spool/devpi >> /var/log/devpi-server.log 2>&1 &"

if [ ! -d /var/spool/git ]; then
    mkdir -p /var/spool/git
    touch /var/log/git-cache-http-server.log
fi
chmod a+rw /var/log/git-cache-http-server.log
chmod -R a+rw /var/spool/git

mkdir -p /var/spool/verdaccio
chmod -R a+rw /var/spool/verdaccio
pushd /var/spool/verdaccio
mkdir -p /var/spool/verdaccio/storage
mkdir -p /var/spool/verdaccio/plugins
chmod a+rw /var/log/verdaccio.log
su nobody -c "verdaccio -c /etc/verdaccio.yaml >> /var/log/verdaccio.log 2>&1 &"
popd

mkdir -p /var/spool/git
chmod -R a+rw /var/spool/git
chmod a+rw /var/log/git-cache-http-server.log
su nobody -c "while :; do git-cache-http-server -c /var/spool/git >> /var/log/git-cache-http-server.log 2>&1 ; done &"
while :; do sleep 200000; done
