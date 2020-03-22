#!/bin/bash
set -e -v

source /tmp/proxy.sh
dnf makecache
dnf upgrade --best --nodocs --allowerasing -y

dnf --setopt=install_weak_deps=False --best install -v -y \
    --nodocs --allowerasing \
    nextcloud18-sqlite \
    apache \
    sudo \
    apache-mod_proxy \
    php-fpm \
    php-cli \
    php-intl \
    php-pcntl \
    openssl

cp /tmp/startup.sh /root
cp /tmp/config.php /etc/nextcloud
cp /tmp/nextcloud.inc /etc/httpd/conf/webapps.d
touch /etc/nextcloud/CAN_INSTALL

cat <<EOF > /etc/php-fpm.d/mem-limit.conf
[www]
php_admin_value[memory_limit] = 512M
EOF

pushd /etc/httpd/conf
cp /tmp/00_mpm.conf modules.d
if [ -e modules.d/00-php-fpm.conf ] ; then
    mv modules.d/00-php-fpm.conf modules.d/10-php-fpm.conf
fi
popd

sed -i -e 's:120;:1200;:'  /usr/share/nextcloud/lib/private/Installer.php
