#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -x /usr/sbin/php-fpm ] ; then
echo "Restarting php-fpm"
sudo -u apache /usr/sbin/php-fpm --nodaemonize --fpm-config /etc/php-fpm.conf >> /var/log/php-fpm.log 2>&1 &
fi
/usr/sbin/httpd -DFOREGROUND
