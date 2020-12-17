#!/bin/bash

set -v
set -o errexit

if [ -f $rootfsDir/tmp/proxy.sh ] ; then
    source $rootfsDir/tmp/proxy.sh
fi
pushd $rootfsDir/tmp
git clone https://github.com/symmetryinvestments/jupyter-wire.git
git clone https://github.com/joequant/dlang-kernel.git
pushd dlang-kernel
dub build
mv dlang_kernel $rootfsDir/usr/bin
mkdir -p $rootfsDir/usr/share/jupyter/kernels/dlang_kernel
cp kernel.json $rootfsDir/usr/share/jupyter/kernels/dlang_kernel
popd
popd
