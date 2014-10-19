#!/bin/sh

version=16.30-1.mga5
arch=x86_64
gitdir=/home/joe/git
stage1ver=2.9-3.mga5

pushd $gitdir
if [ ! -d mageia ] ; then
git clone https://github.com/joequant/mageia.git
fi

cd mageia
git checkout master
git pull
git branch $version
git checkout $version

mkdir -p installer/$arch/install/stage2
cd installer/$arch/install/stage2
rm *.rpm*
wget ftp://ftp.sunet.se/pub/os/Linux/distributions/mageia/distrib/cauldron/x86_64/media/core/release/drakx-installer-stage2-$version.$arch.rpm
rpm2cpio drakx-installer-stage2-$version.$arch.rpm | cpio -idmv
mv ./usr/lib64/drakx-installer-stage2/install/stage2/mdkinst.sqfs .
mv ./usr/lib64/drakx-installer-stage2/install/stage2/VERSION .
rm -rf drakx-installer-stage2-$version.$arch.rpm ./usr
git add mdkinst.sqfs
git add VERSION
popd

