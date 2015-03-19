#!/bin/bash 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PYTHON=`which python2`

cd $SCRIPT_DIR
. ../web/scripts/norootcheck.sh
if [ -d ../../ethercalc ] 
then  echo "Building ethercalc"
pushd ../../ethercalc > /dev/null
npm i
popd > /dev/null
fi

if [ -d ../../dynamic-reverse-proxy ] 
then  echo "Building dynamic-reverse-proxy"
pushd ../../dynamic-reverse-proxy > /dev/null
npm i
popd > /dev/null
fi

if [ -d ../../shiny-server ] 
then  echo "Building ethercalc"
if rpm  -qa | grep -q gyp ; then
echo "gyp is installed.  compile will fail.  please uninstall"]
exit 1
fi
pushd ../../shiny-server > /dev/null
cmake -DCMAKE_INSTALL_PREFIX="/usr/lib" -DPYTHON="/usr/bin/python2"
make
npm --python="$PYTHON" rebuild
ext/node/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js --python="$PYTHON" rebuild
popd > /dev/null
fi
