#!/bin/bash
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_DIR=$1
if [ `uname -m` = "x86_64" -o `uname -m` = " x86-64" ]; then
LIBDIR="lib64"
else
LIBDIR="lib"
fi
pushd $ROOT_SCRIPT_DIR > /dev/null
. rootcheck.sh
popd > /dev/null
pip install --upgrade Quandl rpy2
pushd /usr/$LIBDIR
ln -sf ./R/lib/libR.so libR.so 
popd
