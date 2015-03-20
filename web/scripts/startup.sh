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
ETHERCALC_ARGS="--basepath /calc/ --port 8001" make >> $LOG_DIR/ethercalc.log 2>&1 &
popd > /dev/null
fi

if [ -d $GIT_DIR/dynamic-reverse-proxy ] ; then
pushd $GIT_DIR/dynamic-reverse-proxy > /dev/null
echo "Restarting dynamic reverse proxy"
node $GIT_DIR/dynamic-reverse-proxy/server.js >> $LOG_DIR/dynamic-reverse-proxy.log 2>&1 &
popd > /dev/null
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
mkdir -p ~/irkernel
# Override mathjax so that ipython will pull the a secure mathjax to avoid 
# failures if ipython is pulled through https

/usr/bin/ipython3 notebook --no-browser --NotebookApp.base_url=ipython --NotebookApp.webapp_settings="{'static_url_prefix':'/ipython/static/', 'mathjax_url' : 'https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' }" --notebook-dir=~/ipython --script >> $LOG_DIR/ipython.log 2>&1 &

/usr/bin/ipython3 notebook --no-browser --NotebookApp.base_url=irkernel --NotebookApp.webapp_settings="{'static_url_prefix':'/irkernel/static/', 'mathjax_url' : 'https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML' }" --notebook-dir=~/irkernel --script --port=8890 --KernelManager.kernel_cmd="['R', '-e', 'IRkernel::main()', '--args', '{connection_file}']" >> $LOG_DIR/irkernel.log 2>&1 &
fi


