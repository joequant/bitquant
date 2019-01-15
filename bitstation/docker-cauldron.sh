#!/bin/bash
set -e
dnf install -v -y \
     --setopt=install_weak_deps=False --nodocs --allowerasing --best \
     'dnf-command(config-manager)' mageia-repos-cauldron --nogpgcheck
dnf shell -v -y  <<EOF
config-manager --set-disabled mageia-x86_64 updates-x86_64
config-manager --set-enabled cauldron-x86_64 cauldron-x86_64-nonfree cauldron-x86_64-tainted
EOF
dnf upgrade -v -y --allowerasing --best --nodocs --setopt=install_weak_deps=False -x filesystem



