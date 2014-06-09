#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOG_DIR=$SCRIPT_DIR/log
cd $SCRIPT_DIR
. norootcheck.sh

#ipython notebook &

java_arch="i386"
if [ "`uname -m`" == "x86_64" ] ; then
java_arch="amd64"
fi

if [ -d ../../OG-Platform ] ; then
echo "Restarting opengamma"
pushd ../../OG-Platform/examples/examples-simulated/ > /dev/null
mvn opengamma:server-start -Dconfig=fullstack >> $LOG_DIR/og.log &
popd > /dev/null
fi

if [ -d ../../ethercalc ] ; then
pushd ../../ethercalc > /dev/null
echo "Restarting ethercalc"
ETHERCALC_ARGS="--basepath /calc/" make >> $LOG_DIR/ethercalc.log 2>&1 &
popd > /dev/null
fi

if [ -d ../../etherpad-lite ] ; then
echo "Restarting etherpad"
pushd ../../etherpad-lite > /dev/null
bin/run.sh >> $LOG_DIR/etherpad.log 2>&1 &
popd > /dev/null
fi

if [ -f /usr/bin/rserver ] ; then
echo "Restarting rserver"
/usr/bin/rserver >> $LOG_DIR/rserver.log 2>&1 &
fi

if [ -f /usr/bin/ipython ] ; then
echo "Restarting ipython"
mkdir -p ~/ipython
/usr/bin/ipython notebook --no-browser --NotebookApp.base_url=ipython --NotebookApp.webapp_settings="{'static_url_prefix':'/ipython/static/'}" --notebook-dir=~/ipython >> $LOG_DIR/ipython.log 2>&1 &
fi


