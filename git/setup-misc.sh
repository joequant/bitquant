#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR

pushd ../..
git clone https://github.com/$MY_NAME/JyNI
pushd JyNI
git remote add upstream https://github.com/Stewori/JyNI
git fetch upstream
git fetch origin
popd

git clone https://github.com/$MY_NAME/Fudge-Python
pushd Fudge-Python
git fetch origin
popd

git clone https://github.com/$MY_NAME/XChange
pushd XChange
git remote add upstream https://github.com/timmolter/XChange
git fetch upstream
git fetch origin
popd

git clone https://github.com/$MY_NAME/JSurface3D
pushd JSurface3D
git remote add upstream https://github.com/OpenGamma/JSurface3D
git fetch upstream
git fetch origin
popd

git clone https://github.com/$MY_NAME/zipline
pushd zipline
git remote add upstream https://github.com/quantopian/zipline
git fetch upstream
git fetch origin
popd

git clone https://github.com/$MY_NAME/trade-manager
pushd trade-manager
git remote add upstream https://code.google.com/p/trade-manager/
git fetch upstream
git fetch origin
popd
