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
git remote add upstream https://github.com/jamesc/Fudge-Python
git fetch upstream
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

git clone https://github.com/$MY_NAME/aiotrade
pushd aiotrade
git remote add upstream https://github.com/dcaoyuan/aiotrade
git fetch upstream
git fetch origin
popd


