#!/bin/bash
set -e -v
. /tmp/proxy.sh

cat <<EOF >> /etc/dnf/dnf.conf
fastestmirror=true
max_parallel_downloads=10
EOF

dnf makecache
rpm --erase basesystem-minimal
dnf autoremove -y urpmi perl-URPM perl-Alien-Build \
    perl-XML-LibXML \
    perl-Alien-Libxml2 \
    perl-MDV-Packdrakeng \
    perl-Capture-Tiny \
    perl-FFI-CheckLib \
    perl-Config-IniFiles \
    perl-File-Which \
    perl-File-chdir \
    perl-Path-Tiny \
    perl-XML-SAX-Base \
    perl-XML-NamespaceSupport \
    perl-Time-ZoneInfo \
    perl-Filesys-Df \
    perl-IO-stringy \
    perl-Locale-gettext \
    gzip meta-task \
    sash diffutils vim-minimal libutempter \
    rootfiles diffutils tar

dnf install -v -y \
     --setopt=install_weak_deps=False --nodocs --allowerasing --best \
     'dnf-command(config-manager)' mageia-repos-cauldron --nogpgcheck

dnf shell -v -y  <<EOF
config-manager --set-disabled mageia-x86_64 updates-x86_64 cauldron-updates-x86_64
config-manager --set-enabled cauldron-x86_64 cauldron-x86_64-nonfree cauldron-x86_64-tainted
EOF

dnf upgrade -v -y --allowerasing --best --nodocs --refresh --setopt=install_weak_deps=False
dnf autoremove -y \
    `rpm -qa | grep mga7 | grep -v selinux | grep -v apache| grep -v filesystem`
dnf clean all

rpm --erase --nodeps iputils iproute2 ethtool info-install net-tools kmod dbus

rm -f /var/log/*.log
rm -rf /var/cache/dnf/*
rm -rf /usr/lib/udev
rm -rf /usr/lib/.build-id
rm -rf /code
rm -rf /var/lib/urpmi
rm -rf /usr/share/zoneinfo/right
rm -rf /usr/lib/kbd
rm -rf /etc/udev/hwdb.bin
rm -rf /var/lib/rpm/__db.*

#remove systemd
#Prevent systemd from starting unneeded services
rm -f /usr/etc/systemd/system/*.wants/*
pushd /usr/lib/systemd
rm -f /lib/systemd/systemd
rm -f /lib/systemd/systemd-ac-power
rm -f /lib/systemd/systemd-backlight
rm -f /lib/systemd/systemd-fsck

(cd system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done)
rm -f system/multi-user.target.wants/*
rm -f system/local-fs.target.wants/*
rm -f system/sockets.target.wants/*udev*
rm -f system/sockets.target.wants/*initctl*
rm -f system/basic.target.wants/*
rm -f system/anaconda.target.wants/*
rm -f *udevd* *networkd* *machined* *coredump*
pushd /usr/share/locale
rm -rf `ls | grep -v ISO | grep -v UTF | grep -v en`
popd
popd
