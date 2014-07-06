#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -e

VERSION=v0.0.4
cd ~/.oz/images
cp Bitstation-mageia-net-x86_64.vdi Bitstation-$VERSION-64bit.vdi
zip -9 Bitstation-$VERSION-64bit.vdi.zip Bitstation-$VERSION-64bit.vdi
source $SCRIPT_DIR/rmvbox.sh || echo "done"
rm -f Bitstation-$VERSION-64bit.ova
source $SCRIPT_DIR/mkvbox.sh Bitstation-mageia-net-x86_64.vdi
VBoxManage export Bitstation --output Bitstation-$VERSION-64bit.ova \
   --vsys 0 \
   --product "Bitstation" \
   --vendor "Bitquant Research Laboratories" \
   --vendorurl "http://www.bitquant.com.hk/"

cp Bitstation-mageia-net-i586.vdi Bitstation-$VERSION-32bit.vdi
zip -9 Bitstation-$VERSION-32bit.vdi.zip Bitstation-$VERSION-32bit.vdi

$SCRIPT_DIR/rmvbox32.sh || echo "done"
rm -f Bitstation-$VERSION-32bit.ova
$SCRIPT_DIR/mkvbox32.sh Bitstation-mageia-net-i586.vdi
VBoxManage export Bitstation32 --output Bitstation-$VERSION-32bit.ova \
   --vsys 0 \
   --product "Bitstation" \
   --vendor "Bitquant Research Laboratories" \
   --vendorurl "http://www.bitquant.com.hk/"  
