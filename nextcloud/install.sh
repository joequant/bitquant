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
    apache-mod_proxy \
    php-fpm \
    php-cli \
    php-intl \
    php-pcntl \
    php-redis \
    php-apcu \
    sudo

cat <<EOF > /etc/sudo.conf
Set disable_coredump false
EOF

cp /tmp/startup.sh /root
cp /tmp/config.php /etc/nextcloud

sed -i -e 's:120;:1200;:'  /usr/share/nextcloud/lib/private/Installer.php
