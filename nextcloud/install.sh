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

reposetup="--disablerepo=* --enablerepo=mageia-$buildarch --enablerepo=updates-$buildarch"
#source $script_dir/proxy.sh
(
dnf --installroot="$rootfsDir" \
    $reposetup \
    --forcearch="$buildarch" \
    --setopt=install_weak_deps=False --best -v -y \
    --nodocs --allowerasing \
    --releasever="$releasever" \
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
    sudo \
    tar gzip \
    redis \
    cronie \
    locales-en
)


rpm --erase --root $rootfsDir --nodeps rpm-helper
dnf autoremove --installroot="$rootfsDir"
cat <<EOF > $rootfsDir/etc/sudo.conf
Set disable_coredump false
EOF

# prevent link from accessing outside
pushd $rootfsDir/etc/nextcloud
cp ca-bundle.crt ca-bundle.crt.bak
rm ca-bundle.crt
mv ca-bundle.crt.bak ca-bundle.crt
popd

pushd $rootfsDir
cp $script_dir/startup.sh var/lib/nextcloud
cp $script_dir/config.php etc/nextcloud
cp $script_dir/00_mpm.conf etc/httpd/conf/modules.d
chmod a+x var/lib/nextcloud/startup.sh
chown apache:apache var/lib/nextcloud/startup.sh

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

pushd usr/share/locale
rm -rf `ls | grep -v "^ISO" | grep -v "^UTF" | grep -v "^en" | grep -v "^C.UTF"`
popd
popd
rpm --rebuilddb --root $rootfsDir

buildah config --cmd "/var/lib/nextcloud/startup.sh" $container
buildah commit --format docker --rm $container $name
buildah push $name:latest docker-daemon:$name:latest

