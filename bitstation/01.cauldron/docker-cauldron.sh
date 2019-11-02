#!/bin/bash
set -e -v
. /tmp/proxy.sh

cat <<EOF >> /etc/dnf/dnf.conf
fastestmirror=true
excludepkgs=filesystem,chkconfig
max_parallel_downloads=10
EOF

dnf install -v -y \
     --setopt=install_weak_deps=False --nodocs --allowerasing --best \
     'dnf-command(config-manager)' mageia-repos-cauldron --nogpgcheck

dnf shell -v -y  <<EOF
config-manager --set-disabled mageia-x86_64 updates-x86_64 cauldron-updates-x86_64
config-manager --set-enabled cauldron-x86_64 cauldron-x86_64-nonfree cauldron-x86_64-tainted
EOF

#dnf config-manager --add-repo http://mirrors.kernel.org/mageia/distrib/cauldron/x86_64/media/core/release cauldron
dnf upgrade -v -y --allowerasing --best --nodocs --refresh --setopt=install_weak_deps=False
dnf autoremove -y urpmi
dnf clean all

rm -f /var/log/*.log
rm -rf /var/cache/dnf/*
rm -rf /usr/lib/udev
rm -rf /usr/lib/.build-id
rm -rf /code

#remove systemd
#Prevent systemd from starting unneeded services
rm -f /usr/etc/systemd/system/*.wants/*
pushd /usr/lib/systemd

(cd system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done)
rm -f system/multi-user.target.wants/*
rm -f system/local-fs.target.wants/*
rm -f system/sockets.target.wants/*udev*
rm -f system/sockets.target.wants/*initctl*
rm -f system/basic.target.wants/*
rm -f system/anaconda.target.wants/*
rm -f *udevd* *networkd* *machined* *coredump*
popd
