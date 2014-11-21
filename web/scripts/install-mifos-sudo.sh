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
if [ ! -e /usr/share/tomcat/.keystore ] ; then 
echo "" | keytool -genkey -alias mifostom -keyalg RSA \
  -storepass changeit -noprompt \
  -dname "CN=Unknown, OU=Unknown, O=Unknown, L=Unknown,S=Unknown, C=Unknown" \
  -keystore /usr/share/tomcat/.keystore
fi

