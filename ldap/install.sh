#!/bin/bash
set -e -v

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
container=$(buildah from joequant/cauldron-minimal)
buildah config --label maintainer="Joseph C Wang <joequant@gmail.com>" $container
buildah config --user root $container
mountpoint=$(buildah mount $container)
rootfsDir=$mountpoint
name=joequant/ldap
releasever=cauldron
LANG=C
LANGUAGE=C
LC_ALL=C

if [ -z $buildarch ]; then
	# Attempt to identify target arch
	buildarch="$(rpm --eval '%{_target_cpu}')"
fi

. $scriptDir/proxy.sh

reposetup="--disablerepo=* --enablerepo=mageia-$buildarch --enablerepo=updates-$buildarch"

cp $scriptDir/startup.sh $rootfsDir/sbin/startup.sh
chmod a+rwx $rootfsDir/sbin/startup.sh
(
dnf --installroot="$rootfsDir" \
    --forcearch="$buildarch" \
    --setopt=install_weak_deps=False --best -v -y \
    --nodocs --allowerasing \
    --releasever="$releasever" \
    --nogpgcheck \
    --refresh \
    install \
    389-ds-base \
    cockpit-389-ds \
    cockpit
)

rpm --erase --nodeps --root $rootfsDir systemd \
    `rpm -qa --root $rootfsDir | grep vulkan` \
    `rpm -qa --root $rootfsDir | grep drm` \
    `rpm -qa --root $rootfsDir | grep dri` \
    `rpm -qa --root $rootfsDir | grep wayland` \
    `rpm -qa --root $rootfsDir | grep adwaita`

rpm --rebuilddb --root $rootfsDir
pushd $rootfsDir
rm -rf var/cache/*
rm -f lib/*.so lib/*.so.* lib64/*.a lib/*.a lib/*.o
rm -rf usr/lib/.build-id usr/lib64/mesa
rm -rf usr/local usr/games
rm -rf usr/lib/gcc/*/*/32
#modclean seems to interfere with verdaccio
#https://github.com/verdaccio/verdaccio/issues/1883
popd

buildah config --cmd "/sbin/startup.sh" $container
buildah commit --format docker --rm $container $name
buildah push $name:latest docker-daemon:$name:latest
pump --shutdown
