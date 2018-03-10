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
node app.js --basepath /calc/ --port 8100 >> $LOG_DIR/ethercalc.log 2>&1 &
$SCRIPT_DIR/install-ethercalc.py
popd > /dev/null
fi

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

if [ -f /usr/bin/jupyter-lab ] ; then
    echo "Restarting jupyterlab"
    export PYTHONPATH=$HOME/ipython:$HOME/ipython/examples
    pushd $HOME/ipython
    /usr/bin/jupyter lab --no-browser --NotebookApp.base_url=jupyterlab/ --ip 127.0.0.1 --port 9999 --NotebookApp.token= --NotebookApp.webapp_settings="{'static_url_prefix':'/jupyterlab/static/', 'mathjax_url' : 'https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js' }" --notebook-dir=~/ipython --app-dir='/usr/share/jupyter/lab/' >> $LOG_DIR/jupyterlab.log 2>&1 &
    popd
fi
