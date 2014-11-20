#!/bin/bash
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_DIR=$1
ME=$2

. $ROOT_SCRIPT_DIR/rootcheck.sh
# Mifos set up
if [ -e /bin/mysqladmin ] ; then
mysqladmin password mysql
fi
usermod -a -G tomcat $ME
sed -i -e s/^skip-networking/#skip-networking/ /etc/my.cnf
