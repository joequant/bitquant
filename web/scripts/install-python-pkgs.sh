#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ `uname -m` = "x86_64" -o `uname -m` = " x86-64" ]; then
LIBDIR="lib64"
else
LIBDIR="lib"
fi
pushd $SCRIPT_DIR > /dev/null
. norootcheck.sh
popd > /dev/null
sudo pip install --upgrade Quandl rpy2
pushd /usr/$LIBDIR
sudo ln -sf ./R/lib/libR.so libR.so 
popd
