#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "  mkimg.sh <config> <format>"
    exit 1
fi

CONFIG=$1
FORMAT=$2
# There seems to be a problem with vdi image created by oz
# generate qcow2 image and then convert to vdi
GENFORMAT=$FORMAT
if [ "$FORMAT" == "vdi" ] ; then
GENFORMAT=qcow2
fi

pushd ~/.oz/images > /dev/null
rm -f Mageia.$GENFORMAT $CONFIG.$GENFORMAT
popd > /dev/null
# There seems to be a problem with vdi image creates
oz-install -a Mageia$CONFIG.auto mageia-net.tdl -c oz-$GENFORMAT.cfg  -d3 -t 7200

pushd ~/.oz/images > /dev/null
export TMPDIR=$HOME/tmp
mkdir $TMPDIR

if [ $FORMAT = "vdi" ] ; then
virt-sparsify Mageia.$GENFORMAT tmp.$$.$GENFORMAT
qemu-img convert -O vdi tmp.$$.$GENFORMAT $CONFIG.vdi
rm -f tmp.$$.$GENFORMAT
else
virt-sparsify Mageia.$GENFORMAT $CONFIG.$GENFORMAT
fi
rm -f Mageia.$GENFORMAT
popd > /dev/null
echo "Image $CONFIG.$FORMAT generated in directory ~/.oz/images"

