#!/bin/bash
dnf install -v -y \
       --setopt=install_weak_deps=False --nodocs \
     'dnf-command(config-manager)' mageia-repos-cauldron
dnf config-manager -v -y --set-disabled mageia-x86_64
dnf config-manager -v -y --set-disabled updates-x86_64
dnf config-manager -v -y --set-enabled cauldron-x86_64
dnf config-manager -v -y --set-enabled cauldron-x86_64-nonfree
dnf config-manager -v -y --set-enabled cauldron-x86_64-tainted
dnf config-manager -v -y --add-repo http://mirrors.kernel.org/mageia/distrib/cauldron/x86_64/media/core/release cauldron
dnf --refresh --allowerasing --best distro-sync \
       -v -y --setopt=install_weak_deps=False --nodocs
dnf -v -y --allowerasing --best --nodocs --setopt=install_weak_deps=False upgrade
