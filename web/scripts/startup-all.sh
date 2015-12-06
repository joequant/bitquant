#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_DIR=$SCRIPT_DIR/..
GIT_DIR=$WEB_DIR/../..
LOG_DIR=$WEB_DIR/log
cd $SCRIPT_DIR
. rootcheck.sh

su redis -c "/usr/sbin/redis-server 127.0.0.1:6379"
su mongod -c "/usr/bin/mongod --quiet -f /etc/mongod.conf"
/usr/sbin/httpd -DFOREGROUND

su user -c startup.sh
read -p "pause"

