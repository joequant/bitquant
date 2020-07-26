#!/bin/bash
# remove build deps

set -e -v
source $script_dir/proxy.sh

# don't remove scipy
dnf -y $rootfsArg \
    autoremove \
      cmake \
      libtool \
      automake \
      autoconf \
      swig \
      protobuf-compiler \
      cargo \
      `rpm -qa | grep devel | grep -v python | grep -v glibc | \
grep -v xcrypt | \
grep -v ^gcc | grep -v libstd | grep -v gettext | \
grep -v acl | grep -v croco | grep -v ffi | grep -v blkid | \
grep -v glib | grep -v lzma | grep -v zlib | grep -v xml | \
grep -v mount | grep -v pcre | grep -v uuid | grep -v unistring | \
grep -v ncurses`

dnf -y $rootfsArg \
    autoremove \
    `rpm -qa | grep openjdk` \
    `rpm -qa | grep firefox` \
    `rpm -qa | grep initscripts` \
    `rpm -qa | grep qtbase5-common`

# add iproute2 for webmin
dnf -y $rootfsArg \
    install java-headless iproute2 \
    quantlib-devel pybind11-devel

dnf clean all $rootfsArg
rpm --erase --nodeps systemd mesa $rootfsRpmArg
rpm --erase --nodeps $rootfsRpmArg \
    `rpm -qa $rootfsRpmArg | grep font | grep x11` \
    `rpm -qa $rootfsRpmArg | grep vulkan` adwaita-icon-theme

#set default python to python3
pushd $rootfsDir/usr/bin
ln -sf python3 python
popd

pushd $rootfsDir
rm -rf root/.cache
rm -rf root/.npm
rm -rf root/.superset
rm -rf var/lib/mongodb/journal
rm -rf etc/resolveconf sbin/resolvconf etc/rc.d/init.d/resolvconf
rm -rf usr/lib64/python*/test

find  usr/lib*/python* -name tests | xargs rm -rf
find  usr/lib*/python* -name examples | xargs rm -rf
find  usr/lib*/python* -name testsuite | xargs rm -rf

pushd usr/lib/node_modules
modclean -r -f
popd
rm -rf root/.gitconfig
rm -rf etc/npmrc

rm -rf usr/share/doc
rm -rf usr/share/gems/doc
rm -rf home/user/git/shiny-server
rm -rf home/user/git/ethercalc
rm -rf home/user/.npm/
rm -rf home/user/.node-gyp
rm -rf root/.cache
rm -rf root/.node-gyp
rm -rf usr/local/share
rm -rf usr/lib/.build-id
rm -rf var/cache/*
rm -f lib/*.so lib/*.so.*

#put in link to allow loading of iruby
pushd usr/lib64
ln -s libzmq.so.5 libzmq.so
popd
dnf clean all $rootfsArg

# remove link that moves out of volume to allow running in podman
rm -rf etc/X11
rm -rf etc/alsa
rm -rf etc/fonts

pushd usr/share/locale
rm -rf `ls | grep -v "^ISO" | grep -v "^UTF" | grep -v "^en" | grep -v "^C.UTF"`
popd
rpm --rebuilddb $rootfsRpmArg
chmod -R a+rx var/lib/rpm var/lib/dnf
rm -rf var/cache/*
popd
pump --shutdown
