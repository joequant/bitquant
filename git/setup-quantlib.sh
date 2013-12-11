#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR

pushd ../..
git clone https://github.com/$MY_NAME/quantlib
pushd quantlib
git remote add upstream https://github.com/lballabio/quantlib
git fetch upstream
git fetch origin
popd
