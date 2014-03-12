#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOG_DIR=$SCRIPT_DIR/log
cd $SCRIPT_DIR
. norootcheck.sh

sudo systemctl start httpd.service

#ipython notebook &

if [ -d ../../OG-Platform ] ; then
echo "Restarting opengamma"
pushd ../../OG-Platform/examples/examples-simulated/ > /dev/null
(mvn install >> $LOG_DIR/og.log; mvn opengamma:server-start -Dconfig=fullstack >> $LOG_DIR/og.log) &
popd > /dev/null
fi

if [ -d ../../ethercalc ] ; then
pushd ../../ethercalc > /dev/null
echo "Restarting ethercalc"
make >> $LOG_DIR/ethercalc.log 2>&1 &
popd > /dev/null
fi

if [ -d ../../etherpad-lite ] ; then
echo "Restarting etherpad"
pushd ../../etherpad-lite > /dev/null
bin/run.sh >> $LOG_DIR/etherpad.log 2>&1 &
popd > /dev/null
fi




