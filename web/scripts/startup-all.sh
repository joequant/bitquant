#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_DIR=$SCRIPT_DIR/..
GIT_DIR=$WEB_DIR/../..
LOG_DIR=$WEB_DIR/log
cd $SCRIPT_DIR
. rootcheck.sh

echo "Start redis"
su redis -s "/bin/bash" -c "/usr/bin/redis-server /etc/redis.conf" &
echo "Start mongo"
chown -R mongod:mongod /var/lib/mongodb
su mongod -s "/bin/bash" -c "/usr/bin/mongod --quiet -f /etc/mongod.conf" &
/usr/sbin/httpd -DFOREGROUND &
if [ -f /etc/webmin/start ] ; then
    echo "Start webmin"
    /etc/webmin/start
fi
echo "Pulling git"
pushd $WEB_DIR/..
su user -c "git pull"
popd
su user -c ./startup.sh
while :; do sleep 2; done


