#!/bin/bash
pushd ~/.oz/images > /dev/null
rm -f Mageia.dsk Bitstation.dsk
popd > /dev/null
# There seems to be a problem with vdi image creates
oz-install -a MageiaBitstation.auto mageia-net.tdl -c oz-rawcfg  -d3 -t 7200

pushd ~/.oz/images > /dev/null
export TMPDIR=$HOME/tmp
mkdir $TMPDIR
virt-sparsify Mageia.dsk Bitstation.dsk
rm -f Mageia.dsk
popd > /dev/null

