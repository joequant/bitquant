#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_DIR=$SCRIPT_DIR/..
GIT_DIR=$WEB_DIR/../..
LOG_DIR=$WEB_DIR/log
cd $SCRIPT_DIR
. norootcheck.sh

#ipython notebook &

java_arch="i386"
if [ "`uname -m`" == "x86_64" ] ; then
java_arch="amd64"
fi

if [ -d $GIT_DIR/OG-Platform ] && [ -f /usr/bin/mvn ] ; then
echo "Restarting opengamma"
pushd $GIT_DIR/OG-Platform/examples/examples-simulated/ > /dev/null
mvn opengamma:server-start -Dconfig=bitquant >> $LOG_DIR/og.log &
popd > /dev/null
fi

if [ -d $GIT_DIR/ethercalc ] ; then
pushd $GIT_DIR/ethercalc > /dev/null
echo "Restarting ethercalc"
make all >> $LOG_DIR/ethercalc.log 2>&1
node app.js --basepath /calc/ --port 8001 >> $LOG_DIR/ethercalc.log 2>&1 &
$SCRIPT_DIR/install-ethercalc.py
popd > /dev/null
fi

#if [ -e /usr/bin/ethercalc ] ; then
#    echo "Restarting ethercalc"
#    /usr/bin/ethercalc --port=8001 --basepath=/calc/ >> $LOG_DIR/ethercalc.log 2>&1 &
#fi

if [ -e /usr/bin/configurable-http-proxy ] ; then
echo "Restarting configurable-http-proxy"
configurable-http-proxy --port 9010 --api-port 9011 --no-include-prefix >> $LOG_DIR/configurable-http-proxy 2 >&1 &
fi

if [ -d $GIT_DIR/etherpad-lite ] ; then
echo "Restarting etherpad"
pushd $GIT_DIR/etherpad-lite > /dev/null
bin/run.sh >> $LOG_DIR/etherpad.log 2>&1 &
popd > /dev/null
fi

if [ -f /usr/bin/rserver ] ; then
echo "Restarting rserver"
/usr/bin/rserver >> $LOG_DIR/rserver.log 2>&1 &
fi

if [ -f /usr/bin/ipython3 ] ; then
echo "Restarting ipython"
mkdir -p ~/ipython
# Override mathjax so that ipython will pull the a secure mathjax to avoid 
# failures if ipython is pulled through https
/usr/bin/python3 -m bash_kernel.install --user

/usr/bin/ipython3 notebook --no-browser --NotebookApp.base_url=jupyter --NotebookApp.webapp_settings="{'static_url_prefix':'/jupyter/static/', 'mathjax_url' : 'https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' }" --config=$SCRIPT_DIR/ipython_config.py --notebook-dir=~/ipython --script  >> $LOG_DIR/jupyter.log 2>&1 &
fi


