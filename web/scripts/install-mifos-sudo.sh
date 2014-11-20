#!/bin/bash
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_DIR=$1
ME=$2

. $ROOT_SCRIPT_DIR/rootcheck.sh
# Mifos set up
if [ -e /bin/mysqladmin ] ; then
sed -i -e s/^skip-networking/#skip-networking/ /etc/my.cnf
/usr/sbin/mysqld-prepare-db-dir
/usr/bin/mysqld_safe &
systemctl enable mysqld
mysqladmin password mysql
fi
usermod -a -G tomcat $ME

