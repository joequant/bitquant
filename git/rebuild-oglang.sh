#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ncpus=`nproc`
if [ $ncpus -gt 4 ]; then
ncpus=4
fi

sudo /usr/share/bitquant/mkogdirs-sudo.sh
mkdir -p ~/etc/OpenGammaLtd

arch=$(test "$(uname -m)" = "x86_64" && echo "amd64" || echo "i386")

echo "jvmLibrary=/usr/lib/jvm/java/jre/lib/$arch/server/libjvm.so
jvmProperty.opengamma.configuraton.url=http://localhost:8080/jax/configuration/0/
heartbeatTimeout=60000" > ~/etc/OpenGammaLtd/LanguageIntegration

echo "connectorLogConfiguration=/home/`whoami`/git/OG-PlatformNative/og-language/src/package/ai/log4cxx.properties
serviceExecutable=/home/`whoami`/git/OG-PlatformNative/og-language/target/run/Release/ServiceRunner
connectTimeout=60000" > ~/etc/OpenGammaLtd/OpenGammaR

pushd  $SCRIPT_DIR/../../OG-PlatformNative
export MVN_ARGS="-Dmaven.test.skip=true"
ant configure -Dprofile.nix=true -Dtool.cpptasks=true 
# -Dtool.r=true
ant install -Dskip.tests=true
#pushd /home/joe/git/OG-PlatformNative/og-language/target/run/Debug
#./ServiceRunner run >& $SCRIPT_DIR/../web/log/ServiceRunner.log &
#popd
#sleep 10
pushd og-rstats/target/package
export OG_RSTATS_TARGET=../../../

# Without this the installation will try to put the R library in the
# system directories where it does not have permissions
mkdir -p ~/R/`uname -m`-mageia-linux-gnu-library/3.0
mkdir -p ~/R/`uname -m`-mageia-linux-gnu-library/3.1
R CMD INSTALL OpenGamma --no-test-load
popd
popd
#killall ServiceRunner







