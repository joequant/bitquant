#!/bin/bash
# remove build deps

set -e -v
source /tmp/proxy.sh

# don't remove scipy
dnf -y \
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

dnf -y \
    autoremove \
    `rpm -qa | grep openjdk` \
    `rpm -qa | grep firefox` \
    `rpm -qa | grep initscripts` \
    `rpm -qa | grep qtbase5-common`

# add iproute2 for webmit
dnf -y \
    install java-headless iproute2

dnf clean all
rpm --erase --nodeps systemd

#set default python to python3
pushd /usr/bin
ln -sf python3 python
popd

rm -rf /root/.cache
rm -rf /root/.npm
rm -rf /root/.superset
rm -rf /var/lib/mongodb/journal
rm -rf /etc/resolveconf /sbin/resolvconf /etc/rc.d/init.d/resolvconf
rm -rf /usr/lib64/python*/test

find  /usr/lib*/python* -name tests | xargs rm -rf
find  /usr/lib*/python* -name examples | xargs rm -rf
find  /usr/lib*/python* -name testsuite | xargs rm -rf

rm -rf /usr/share/doc
rm -rf /usr/share/gems/doc
rm -rf /home/user/git/shiny-server
rm -rf /home/user/git/ethercalc
rm -rf /home/user/.npm/
rm -rf /home/user/.node-gyp
rm -rf /root/.cache
rm -rf /root/.node-gyp
rm -rf /usr/local/share
rm -rf /usr/lib/.build-id
rm -rf /var/cache/*
rm -f /lib/*.so /lib/*.so.*

jupyter lab clean
jlpm cache clean
npm cache clean --force
pushd /usr/lib/node_modules
modclean -r -f
popd

# Reset npm registry
npm config delete registry
git config --unset --global http.proxy || true
git config --unset --global http.sslVerify || true
git config --unset --global url."$GIT_PROXY".insteadOf || true

#put in link to allow loading of iruby
ln -s /usr/lib64/libzmq.so.5 /usr/lib64/libzmq.so
dnf clean all

# remove link that moves out of volume to allow running in podman
rm -rf /etc/X11
rm -rf /etc/alsa
rm -rf /etc/fonts

pushd /usr/share/locale
rm -rf `ls | grep -v "^ISO" | grep -v "^UTF" | grep -v "^en" | grep -v "^C.UTF"`
popd
rpm --rebuilddb
rm -rf /var/cache/*
