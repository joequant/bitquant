#!/bin/bash
# remove build deps

set -e -v

if [[ $UID -ne 0 ]]; then
  SUDO=sudo
fi

$SUDO dnf -y \
      autoremove \
      cmake \
      gcc-c++ \
      elfutils \
      dmsetup \
      lib64python2.7-stdlib \
      libtool \
      automake \
      autoconf \
      swig \
      protobuf-compiler \
      `rpm -qa | grep devel | grep -v python | grep -v glibc | grep -v xcrypt`

$SUDO dnf clean all
#set default python to python3
pushd /usr/bin
$SUDO ln -sf python3 python
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
rm -rf /usr/lib64/python*/site-packages/pandas/tests
rm -rf /usr/lib64/python*/site-packages/pandas/io/tests
rm -rf /usr/lib64/python*/site-packages/pandas/tseries/tests
rm -rf /usr/lib64/python*/site-packages/matplotlib/tests
rm -rf /usr/lib64/python*/site-packages/mpl_toolkits/tests
rm -rf /usr/lib64/python*/site-packages/numpy/core/tests
rm -rf /usr/lib64/python*/site-packages/spacy/tests
rm -rf /usr/lib/python*/site-packages/holoviews/examples
rm -rf /usr/lib/python*/site-packages/pyspark/examples
rm -rf /usr/lib/python*/site-packages/sonnet/examples
rm -rf /usr/lib/python*/site-packages/allennlp/tests
rm -rf /usr/lib/python*/site-packages/flask/testsuite
rm -rf /usr/lib/python*/site-packages/jinja2/testsuite
rm -rf /usr/lib/python*/site-packages/ggplot/tests
rm -rf /usr/lib/python*/site-packages/sympy/*/tests
rm -rf /usr/share/doc
rm -rf /home/user/git/shiny-server
rm -rf /root/.cache
rm -rf /usr/local/share

# Reset npm registry
npm config delete registry
git config --unset --global http.proxy || true
git config --unset --global http.sslVerify || true
git config --unset --global url."http://localhost:8080/".insteadOf || true

#put in link to allow loading of iruby
ln -s /usr/lib64/libzmq.so.5 /usr/lib64/libzmq.so
dnf clean all
