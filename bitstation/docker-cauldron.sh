#!/bin/bash
dnf install -v -y \
     --setopt=install_weak_deps=False --nodocs --allowerasing --best \
     'dnf-command(config-manager)' mageia-repos-cauldron
dnf shell -v -y  <<EOF
repo disable mageia-x86_64
repo disable updates-x86_64
repo enable cauldron-x86_64
repo enable cauldron-x86_64-nonfree
repo enable cauldron-x86_64-tainted
run
EOF
dnf upgrade -y -v --allowerasing --best --nodocs --setopt=install_weak_deps=False
