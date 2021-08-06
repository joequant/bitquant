#!/bin/bash
set -e -v

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
container=$(buildah from joequant/cauldron)
buildah config --label maintainer="Joseph C Wang <joequant@gmail.com>" $container
mountpoint=$(buildah mount $container)
rootfsDir=$mountpoint
name=joequant/nextcloud
releasever=cauldron
LANG=C
LANGUAGE=C
LC_ALL=C

if [ -z $buildarch ]; then
	# Attempt to identify target arch
	buildarch="$(rpm --eval '%{_target_cpu}')"
fi

. $script_dir/proxy.sh

systemd-sysusers --root=$rootfsDir $script_dir/system.conf
#source $script_dir/proxy.sh
(
dnf --installroot="$rootfsDir" \
    --forcearch="$buildarch" \
    --setopt=install_weak_deps=False --best -v -y \
    --nodocs --allowerasing \
    --releasever="$releasever" \
    --nogpgcheck \
    --refresh \
    install \
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
    php-posix \
    sudo \
    tar gzip \
    redis \
    cronie \
    locales-en \
    curl \
    timezone \
    psmisc \
    php-fpm-apache \
    nodejs \
    git
)

rpm --erase --nodeps systemd --root $rootfsDir
cat <<EOF > $rootfsDir/etc/sudo.conf
Set disable_coredump false
EOF

# prevent link from accessing outside
pushd $rootfsDir/etc/nextcloud
rm ca-bundle.crt
popd

pushd $rootfsDir
cp $script_dir/startup-nextcloud.sh sbin
cp $script_dir/config.php etc/nextcloud
cp $script_dir/00_mpm.conf etc/httpd/conf/modules.d
cp $script_dir/wait-for-it.sh sbin
chmod a+x sbin/startup-nextcloud.sh
chmod a+x sbin/wait-for-it.sh
chown apache:apache sbin/startup-nextcloud.sh

#buildah run $container sudo /usr/sbin/nextcloud-install.sh

dnf --installroot="$rootfsDir" -y \
    autoremove nodejs git

sed -i -e 's/Listen 80/Listen ${HTTP_PORT}/' etc/httpd/conf/httpd.conf

cat > var/spool/cron/apache - <<EOF
*/1 * * * * php -f /usr/share/nextcloud/cron.php
#*/1 * * * * php  -d memory_limit=512M /usr/share/nextcloud/occ documentserver:flush
EOF

sed -i -e 's:120;:1200;:'  usr/share/nextcloud/lib/private/Installer.php

rm -rf usr/lib/.build-id
rm -rf usr/lib/python3.7
rm -rf usr/lib/systemd
rm -rf var/cache/*
rm -f var/lib/dnf/history.*
rm -f lib/*.so
rm -f lib/*.so.*

pushd usr/share/locale
rm -rf `ls | grep -v "^ISO" | grep -v "^UTF" | grep -v "^en" | grep -v "^C.UTF"`
popd
popd
find $rootfsDir/usr -regex '^.*\(__pycache__\|\.py[co]\)$' -delete

#rpm --rebuilddb --root $rootfsDir


buildah config --cmd "/sbin/startup-nextcloud.sh" $container
buildah config --user "root" $container
buildah config --env HTTP_PORT=80 $container
buildah commit --format docker --rm $container $name
buildah push $name:latest docker-daemon:$name:latest

