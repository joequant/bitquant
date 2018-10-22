#!/bin/bash
dnf install --setopt=install_weak_deps=False --nodocs --allowerasing --best 'dnf-command(config-manager)' mageia-repos-cauldron -v -y
dnf shell -v -y  <<EOF
repo disable mageia-x86_64
repo disable updates-x86_64
repo enable cauldron-x86_64
repo enable cauldron-x86_64-nonfree
repo enable cauldron-x86_64-tainted
config-manager  --add-repo http://mirrors.kernel.org/mageia/distrib/cauldron/x86_64/media/core/release cauldron
run
upgrade --allowerasing --best --nodocs --setopt=install_weak_deps=False
run
EOF

