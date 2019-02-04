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
      `rpm -qa | grep devel | grep -v python | grep -v glibc | grep -v xcrypt`

#set default python to python3
pushd /usr/bin
$SUDO ln -sf python3 python
popd
