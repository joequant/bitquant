#!/bin/bash
pushd ~/.oz/images
rm -f Bitstation.vdi Mageia.qcow2
popd
# There seems to be a problem with vdi image creates
oz-install -a MageiaBitstation.auto mageia-net.tdl -c oz-qcow2.cfg  -d3 -t 3600

pushd ~/.oz/images
export TMPDIR=$HOME/tmp
mkdir $TMPDIR
virt-sparsify Mageia.qcow2 Bitstation.qcow2
qemu-img convert -O vdi Bitstation.qcow2 Bitstation.vdi
rm -f Mageia.qcow2 Bitstation.qcow2
popd
