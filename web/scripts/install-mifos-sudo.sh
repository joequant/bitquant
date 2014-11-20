#!/bin/bash
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_DIR=$1
ME=$2

. $ROOT_SCRIPT_DIR/rootcheck.sh
# Mifos set up
sed -i -e s/^skip-networking/#skip-networking/ /etc/my.cnf

systemctl enable mysqld
systemctl restart mysqld
if [ -e /bin/mysqladmin ] ; then
mysqladmin password mysql
fi
usermod -a -G tomcat $ME

