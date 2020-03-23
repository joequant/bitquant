#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -e /etc/nextcloud/CAN_INSTALL ] ; then
    echo "waiting..."
    sleep 10
chown apache:apache -R /usr/share/nextcloud
pushd /usr/share/nextcloud
sudo -u apache php -d memory_limit=512M \
     occ maintenance:install \
     --database="pgsql" --database-name="nextcloud" \
     --database-host="db" --database-user="postgres" \
     --database-pass="mypass" --admin-user="admin" \
     --admin-pass="password" --data-dir="/var/lib/nextcloud/data"
chown root:root -R /usr/share/nextcloud
sudo -u apache php occ config:system:set \
     trusted_domains 1 "--value=*"

for app in \
	onlyoffice \
	calendar \
        maps \
	contacts \
	tasks \
	mail \
	notes \
	deck \
	text \
	groupfolders \
	sociallogin \
	documentserver_community
do
sudo -u apache php -d memory_limit=512M \
     occ app:enable $app
done
popd
rm /etc/nextcloud/CAN_INSTALL
fi

: ' \
	calendar \
	maps \
	contacts \
	mail \
	tasks \

	files_markdown \
	notes \
	files_mindmap \
	deck \
'


if [ -x /usr/sbin/php-fpm ] ; then
echo "Restarting php-fpm"
/usr/sbin/php-fpm --nodaemonize --fpm-config /etc/php-fpm.conf >> /var/log/php-fpm.log 2>&1 &
fi
/usr/sbin/httpd -DFOREGROUND



