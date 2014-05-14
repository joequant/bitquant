#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OG_COMPILE_PLATFORM_NATIVE=1
ncpus=`nproc`
if [ $ncpus -gt 4 ]; then
ncpus=4
fi

if [ -e $HOME/bitquant.conf ] ;  then
echo "Reading configuration from $HOME/bitquant.conf"
. $HOME/bitquant.conf
fi
cd $SCRIPT_DIR
. ../web/norootcheck.sh
pushd ../../OG-Platform  > /dev/null
pushd examples/examples-simulated > /dev/null
mvn -T$ncpus install -Dmaven.test.skip=True
mvn opengamma:server-stop -Dconfig=fullstack
mvn opengamma:server-init -Dconfig=fullstack
mvn opengamma:server-start -Dconfig=fullstack
popd > /dev/null
popd > /dev/null


if [ -n "$OG_COMPILE_PLATFORM_NATIVE" ]; then
pushd ../../OG-Tools/corporate-parent > /dev/null
mvn -T$ncpus install
popd > /dev/null

source $SCRIPT_DIR/rebuild-oglang.sh
fi

