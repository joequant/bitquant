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

if [ -f  ../../OG-PlatformNative/og-language/target/run/Release/ServiceRunner ] ; then
echo "Restarting language connector"
sudo mkdir -p /var/run/opengamma
sudo chmod a+rwx /var/run/opengamma

sudo mkdir -p /var/log/OG-RStats
sudo chmod a+rwx /var/log/OG-RStats

mkdir -p ~/etc/OpenGammaLtd
echo "jvmLibrary=/usr/lib/jvm/java/jre/lib/${java_arch}/server/libjvm.so
jvmProperty.opengamma.configuraton.url=http://localhost:8080/jax/configuration/0/
heartbeatTimeout=60000" > ~/etc/OpenGammaLtd/LanguageIntegration

#serviceExecutable=/home/joe/git/OG-PlatformNative/og-language/target/run/Release/ServiceRunner
echo "connectorLogConfiguration=/home/`whoami`/git/OG-PlatformNative/og-language/src/package/ai/log4cxx.properties
serviceExecutable=/home/`whoami`/git/OG-PlatformNative/og-language/target/run/Release/ServiceRunner
connectTimeout=60000" > ~/etc/OpenGammaLtd/OpenGammaR

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

if [ -f /usr/bin/rserver ] ; then
echo "Restarting rserver"
/usr/bin/rserver >> $LOG_DIR/rserver.log 2>&1 &
fi


