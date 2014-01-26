#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd /var/www/html
rm -f *
for i in $SCRIPT_DIR/bitquant/*; do 
echo $(basename $i)
ln -s -f  ../../..$SCRIPT_DIR/bitquant/$(basename $i) $(basename $i)
done


