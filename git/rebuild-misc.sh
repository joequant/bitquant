#!/bin/bash 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
. ../web/norootcheck.sh
if [ -d ../../ethercalc ] 
then  echo "Building ethercalc"
pushd ../../ethercalc > /dev/null
npm i
popd > /dev/null
fi
