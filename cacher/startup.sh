#!/bin/bash
echo "starting"

mkdir -p /var/spool/squid
chown -R squid:squid /var/spool/squid
if [ ! -d /var/spool/squid/00 ]; then
    /sbin/squid -z -F --foreground >> /var/log/squid/squid.out 2>&1
fi

/sbin/squid -N >> /var/log/squid/squid.out 2>&1 &

CCACHE_DIR=/var/spool/ccache
PATH=/usr/lib64/ccache/bin:/usr/bin
/usr/bin/distccd --verbose --no-detach --verbose --allow 172.0.0.0/24 --allow 192.168.0.0/16 --allow 127.0.0.1 >> /var/log/distccd.log 2>&1 &
devpi-server >> /var/log/devpi-server.log 2>&1 &
git-cache-http-server $GIT_CACHE_ARGS >> /var/log/git-cache-http-server.log 2>&1 &
verdaccio >> /var/log/verdaccio.log 2>&1 &

while :; do sleep 2073600; done
