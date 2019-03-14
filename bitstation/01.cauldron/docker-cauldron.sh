#!/bin/bash
set -e
#export http_proxy=http://172.17.0.1:3128/
#export https_proxy=http://172.17.0.1:3128/
#export ftp_proxy=http://172.17.0.1:3128/
#export HTTP_PROXY=http://172.17.0.1:3128/
#export PIP_INDEX_URL=http://localhost:3141/root/pypi/+simple/
#export GIT_PROXY=http://localhost:8080/

dnf install -v -y \
     --setopt=install_weak_deps=False --nodocs --allowerasing --best \
     'dnf-command(config-manager)' mageia-repos-cauldron --nogpgcheck
dnf shell -v -y  <<EOF
config-manager --set-disabled mageia-x86_64 updates-x86_64
config-manager --set-enabled cauldron-x86_64 cauldron-x86_64-nonfree cauldron-x86_64-tainted
EOF
dnf config-manager --add-repo http://mirrors.kernel.org/mageia/distrib/cauldron/x86_64/media/core/release cauldron
dnf upgrade -v -y --allowerasing --best --nodocs --setopt=install_weak_deps=False -x filesystem -x chkconfig
rpm -qa | grep mga6 | xargs dnf autoremove -y -x filesystem,chkconfig
dnf clean all



