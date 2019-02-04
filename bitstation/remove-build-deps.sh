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
      `rpm -qa | grep devel | grep -v python | grep -v glibc | grep -v xcrypt`
