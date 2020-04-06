#!/bin/bash
set -e -v

source /tmp/proxy.sh
dnf makecache
dnf upgrade --best --nodocs --allowerasing -y

dnf --setopt=install_weak_deps=False --best install -v -y \
    --nodocs --allowerasing \
    nextcloud-sqlite \
    nextcloud-postgresql \
    apache \
    apache-mod_proxy \
    php-fpm \
    php-cli \
    php-intl \
    php-pcntl \
    php-redis \
    php-apcu \
    sudo \
    tar gzip \
    redis

cat <<EOF > /etc/sudo.conf
Set disable_coredump false
EOF

cp /tmp/startup.sh /root
cp /tmp/startup.sh /var/lib/nextcloud
cp /tmp/config.php /etc/nextcloud

sed -i -e 's:120;:1200;:'  /usr/share/nextcloud/lib/private/Installer.php

rm -rf /usr/lib/.build-id
rm -rf /usr/lib/python3.7
rm -rf /usr/lib/systemd
rm -rf /var/cache/*
rm -f /var/lib/dnf/history.*

pushd /usr/share/locale
rm -rf `ls | grep -v "^ISO" | grep -v "^UTF" | grep -v "^en" | grep -v "^C.UTF"`
popd
rpm --rebuilddb
