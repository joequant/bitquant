#!/bin/bash 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PYTHON=`which python2`

cd $SCRIPT_DIR
. ../web/scripts/norootcheck.sh
for repo in ethercalc dynamic-reverse-proxy configurable-http-proxy
do
if [ -d "../../$repo" ]
then  echo "Building $repo"
pushd ../../$repo > /dev/null
npm i
popd > /dev/null
fi
done

if [ -d ../../shiny-server ] 
then  echo "Building shiny-server"
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
