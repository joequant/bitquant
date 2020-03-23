#!/bin/bash
set -e -v

source /tmp/proxy.sh
dnf makecache
dnf upgrade --best --nodocs --allowerasing -y

dnf --setopt=install_weak_deps=False --best install -v -y \
    --nodocs --allowerasing \
    nextcloud18-sqlite \
    nextcloud18-postgresql \
    nextcloud18-mysql \
    apache \
    sudo \
    apache-mod_proxy \
    php-fpm \
    php-cli \
    php-intl \
    php-pcntl

cp /tmp/startup.sh /root
cp /tmp/config.php /etc/nextcloud
touch /etc/nextcloud/CAN_INSTALL

sed -i -e 's:120;:1200;:'  /usr/share/nextcloud/lib/private/Installer.php
