#!/bin/bash

set -v
set +o errexit

source $rootfsDir/tmp/proxy.sh
pushd $rootfsDir/tmp
git clone https://github.com/joequant/jupyter-wire.git/
pushd jupyter-wire
dub build
pushd example/dlang_kernel
dub build
mv dlang_kernel $rootfsDir/usr/bin
mkdir -p $rootfsDir/usr/share/jupyter/kernels/dlang_kernel
cp kernel.json $rootfsDir/usr/share/jupyter/kernels/dlang_kernel
popd
popd
popd
