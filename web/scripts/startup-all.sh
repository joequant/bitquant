#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_DIR=$SCRIPT_DIR/..
GIT_DIR=$WEB_DIR/../..
LOG_DIR=$WEB_DIR/log
cd $SCRIPT_DIR
. rootcheck.sh

su -c redis "/usr/sbin/redis-server 127.0.0.1:6379"
su -c mongod "/usr/bin/mongod --quiet -f /etc/mongod.conf"
/usr/sbin/httpd -DFOREGROUND

su -c user startup.sh
