#!/bin/bash
IFS='.'
read -ra ARR <<< $(basename "$1")
IFS=' '

volname="${ARR[0]}"
compression="${ARR[-1]}"

echo "Moving ${1} into ${volname}"

cat  $1 |  podman run -i -v $volname:/volume --rm loomchild/volume-backup restore -c $compression -
#cat demo_home.20200503.113330.tar.xz  | tar -J -tf -

