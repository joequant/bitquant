#!/bin/bash

#skip libvirt 
export LIBGUESTFS_BACKEND=direct

if [ "$#" -lt 2 ]; then
    echo "Illegal number of parameters"
    echo "  mkimg.sh <config> <format> <distrofile>"
    exit 1
fi

CONFIG=$1
FORMAT=$2

if [ "$#" -gt 2 ]; then
LOADER=$3
else
LOADER="mageia-net"
fi

# There seems to be a problem with vdi image created by oz
# generate qcow2 image and then convert to vdi
GENFORMAT=$FORMAT
if [ "$FORMAT" == "vdi" ] ; then
GENFORMAT=qcow2
fi

mkdir -p ~/.oz/images
pushd ~/.oz/images > /dev/null
rm -f $LOADER.$GENFORMAT $CONFIG.$GENFORMAT
popd > /dev/null
# There seems to be a problem with vdi image creates
oz-install -a $CONFIG.auto $LOADER.tdl -c oz-$GENFORMAT.cfg  -d3 -t 7200

pushd ~/.oz/images > /dev/null
export TMPDIR=$HOME/tmp
mkdir $TMPDIR

if [ $FORMAT = "vdi" ] ; then
virt-sparsify $LOADER.$GENFORMAT tmp.$$.$GENFORMAT
qemu-img convert -O vdi tmp.$$.$GENFORMAT $CONFIG-$LOADER.vdi
rm -f tmp.$$.$GENFORMAT
else
virt-sparsify $LOADER.$GENFORMAT $CONFIG-$LOADER.$GENFORMAT
fi
rm -f $LOADER.$GENFORMAT
popd > /dev/null
echo "Image created in directory ~/.oz/images/$CONFIG-$LOADER.$FORMAT"

