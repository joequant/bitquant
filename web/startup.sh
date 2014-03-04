#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

echo "Restarting apache"
sudo systemctl restart httpd
#ipython notebook &

if [ -d ../../OG-Platform ] ; then
echo "Restarting opengamma"
pushd ../../OG-Platform/examples/examples-simulated/ > /dev/null
(mvn install >> $SCRIPT_DIR/og.log; mvn opengamma:server-start -Dconfig=fullstack >> $SCRIPT_DIR/og.log) &
popd > /dev/null
fi

if [ -d ../../ethercalc ] ; then
pushd ../../ethercalc > /dev/null
echo "Restarting ethercalc"
make >> $SCRIPT_DIR/ethercalc.log 2>&1 &
popd > /dev/null
fi

if [ -d ../../etherpad-lite ] ; then
echo "Restarting etherpad"
pushd ../../etherpad-lite > /dev/null
bin/run.sh >> $SCRIPT_DIR/etherpad.log 2>&1 &
popd > /dev/null
fi




