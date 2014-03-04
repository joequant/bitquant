#!/bin/bash

. ../web/rootcheck.sh

# install deps to build oz image

urpmi --no-suggests --auto \
   oz qemu libguestfs-tools \
   libvirt-utils tigervnc \
   dnsmasq dnsmasq-utils lvm2

systemctl start libvirtd.service




