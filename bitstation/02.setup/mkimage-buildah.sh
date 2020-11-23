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
export rootfsLdconfigArg="-r $mountpoint"
export LC_ALL=C
export LANGUAGE=C
export LANG=C
name="joequant/bitstation"
cp $script_dir/*.sh $rootfsDir/tmp
chmod a+x $rootfsDir/tmp/*.sh
systemd-sysusers --root=$rootfsDir $script_dir/system.conf
source $script_dir/00-install-pkgs.sh

pushd $rootfsDir/etc/httpd/conf
rm -f conf.d/security.conf
cp $script_dir/00_mpm.conf modules.d
if [ -e modules.d/00-php-fpm.conf ] ; then
    mv modules.d/00-php-fpm.conf modules.d/10-php-fpm.conf
fi
popd

buildah run $container parallel --halt 2 --tagstring '{}' --linebuffer source '/tmp/{}' :::  01-install-r-pkgs.sh 01-install-python.sh 01-install-npm.sh 01-install-ruby.sh 01-install-dlang.sh
buildah run $container /bin/bash /tmp/02-docker-setup.sh
buildah run $container /bin/bash /tmp/03-install-jupyter.sh
source $script_dir/04-remove-build-deps.sh

cat > $rootfsDir/usr/share/bitquant/bitquant.sh <<EOF
build_date='$(date)'
commit_id=$(git rev-parse --verify HEAD)
EOF

buildah run $container /bin/bash /tmp/05-log-items.sh
rm -rf $rootfsDir/tmp/*

buildah config --cmd  "/home/user/git/bitquant/bitstation/web/scripts/startup-all.sh" $container

buildah commit --format docker --squash --rm $container $name
buildah push $name:latest docker-daemon:$name:latest

