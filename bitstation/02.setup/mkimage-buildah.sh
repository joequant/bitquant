#!/usr/bin/env bash

set -e -v

mkimg="$(basename "$0")"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
container=$(buildah from joequant/cauldron)

buildah config --label maintainer="Joseph C Wang <joequant@gmail.com>" $container
buildah config --user root $container
mountpoint=$(buildah mount $container)

export rootfsDir=$mountpoint
export rootfsArg="--installroot=$mountpoint"
export rootfsRpmArg="--root $mountpoint"
export LC_ALL=C
export LANGUAGE=C
export LANG=C
name="joequant/bitstation"
mkdir -p $rootfsDir/etc/sysusers.d
cp $script_dir/system.conf $rootfsDir/etc/sysusers.d
cp $script_dir/*.conf $script_dir/*.sh $rootfsDir/tmp
chmod a+x $rootfsDir/tmp/*.sh
systemd-sysusers --root=$rootfsDir
source $script_dir/install-pkgs.sh

buildah run $container -- parallel --tagstring '{}' --linebuffer /bin/bash '/tmp/{}' :::  install-r-pkgs.sh install-python.sh
buildah run $container -- /bin/bash /tmp/proxy-pump-stop.sh
buildah run $container -- /bin/bash /tmp/docker-setup.sh
buildah run $container -- parallel --tagstring '{}' --linebuffer /bin/bash '/tmp/{}' :::  install-npm.sh install-ruby.sh install-r-pkgs-sudo.sh
buildah run $container -- /bin/bash /tmp/remove-build-deps.sh
buildah run $container -- /bin/bash /tmp/proxy-pump-stop.sh
rm -rf $rootfsDir/tmp/*

buildah config --user "user" $container
buildah config --cmd  "/home/user/git/bitquant/bitstation/web/scripts/startup-all.sh" $container

buildah commit --format docker --rm $container $name
buildah push $name:latest docker-daemon:$name:latest

