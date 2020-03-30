#!/bin/bash
# remove build deps

set -e -v
source /tmp/proxy.sh
dnf -y \
      autoremove \
      cmake \
      lib64python2.7-stdlib \
      libtool \
      automake \
      autoconf \
      swig \
      protobuf-compiler \
      `rpm -qa | grep devel | grep -v python | grep -v glibc | grep -v xcrypt | grep -v "gcc-c++"`

dnf -y \
    autoremove \
    `rpm -qa | grep openjdk`

dnf -y \
    install java-headless

dnf clean all
#set default python to python3
pushd /usr/bin
ln -sf python3 python
popd

rm -rf /root/.cache
rm -rf /root/.npm
rm -rf /root/.superset
rm -rf /var/lib/mongodb/journal
rm -f /lib/systemd/system/multi-user.target.wants/*
rm -f /etc/systemd/system/*.wants/*
rm -f /lib/systemd/system/local-fs.target.wants/*
rm -f /lib/systemd/system/sockets.target.wants/*udev*
rm -f /lib/systemd/system/sockets.target.wants/*initctl*
rm -f /lib/systemd/system/basic.target.wants/*
rm -f /lib/systemd/system/anaconda.target.wants/*
rm -f /lib/systemd/system/*resolve1*
rm -f /lib/systemd/system/*resolved*
rm -f /lib/systemd/system/*udev*
rm -f /lib/systemd/system/*journal*
rm -f /lib/systemd/system/*networkd*
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

pushd /usr/share/locale
rm -rf `ls | grep -v "^ISO" | grep -v "^UTF" | grep -v "^en" | grep -v "^C.UTF"`
popd
