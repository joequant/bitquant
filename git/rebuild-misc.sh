#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
if [ -d ../../ethercalc ] 
then pushd ../../ethercalc
npm i
popd
fi
