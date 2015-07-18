#!/bin/bash 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PYTHON=`which python2`

cd $SCRIPT_DIR
. ../web/scripts/norootcheck.sh
for repo in ethercalc
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

if [ ! -e /usr/bin/node-gyp ] ; then
echo "node-gyp is not present please run install-npm.sh"
exit 1
fi

pushd ../../shiny-server > /dev/null
git checkout .
sed -i -e "s!add_subdirectory(external/node)!!g" CMakeLists.txt
sed -i -e "s!add_subdirectory(external/pandoc)!!g" CMakeLists.txt
mkdir -p ext/node/bin
pushd ext/node/bin > /dev/null
ln -s /usr/bin/node shiny-server
popd > /dev/null
cmake -DCMAKE_INSTALL_PREFIX="/usr/lib" -DPYTHON="/usr/bin/python2" .
make
npm --python="$PYTHON" rebuild
npm --python="$PYTHON" install node-gyp
node-gyp --python="$PYTHON" rebuild
git checkout .
popd > /dev/null
fi
