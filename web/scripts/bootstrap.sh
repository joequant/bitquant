#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPT_DIR/environment.sh

OPTS=$(getopt -o "" --long with-mifos,with-opengamma,no-mifos,no-opengamma -- "$@")

eval set -- "$OPTS"

while true; do
   case "$1" in
      --with-mifos )  INSTALL_MIFOS=true ; shift ;;
      --with-opengamma ) INSTALL_OPENGAMMA=true ; shift ;;
      --no-mifos )  INSTALL_MIFOS=false ; shift ;;
      --no-opengamma ) INSTALL_OPENGAMMA=false ; shift ;;
      -- ) shift ; break ;;
      * ) break ;;
   esac
done

echo "Running from directory $GIT_DIR as user "`whoami`
echo "Doing initial installation"
echo "Installing misc"
$GIT_DIR/git/setup-misc.sh
$GIT_DIR/git/rebuild-misc.sh
echo "Installing R packages"
$GIT_DIR/web/scripts/install-r-pkgs.sh
echo "Installing python packages"
$GIT_DIR/web/scripts/install-python.sh

if [[ "$INSTALL_MIFOS" == "true" ]] ; then
echo "Installing mifos"
$GIT_DIR/web/scripts/install-mifos.sh
fi

if [[ "$INSTALL_OPENGAMMA" == "true" ]] ; then
echo "Installing OpenGamma"
$GIT_DIR/git/setup-og.sh
$GIT_DIR/git/rebuild-og.sh
fi

#set wiki conf
echo "Set up wiki"
sudo /usr/share/bitquant/conf.sh /wiki-unlock
sudo /usr/share/bitquant/conf.sh /wiki-init

if [ -f /usr/bin/webmin ] ; then
echo "Set up webmin"
sudo /usr/share/bitquant/conf.sh /webmin-init
fi

echo "Set up ipython"
mkdir -p $MY_HOME/ipython
ln -s -f ../git/bitquant/web/home/ipython/examples $MY_HOME/ipython/examples

echo "Set up R"
mkdir -p $MY_HOME/R
cp -r $GIT_DIR/web/home/R/* $MY_HOME/R
mkdir -p $MY_HOME/irkernel
ln -s -f ../git/bitquant/web/home/irkernel/examples $MY_HOME/irkernel/examples

# Refresh configurations
# This replaces the ajenti configuration with a 
# version that does not use ssl
sudo /usr/share/bitquant/conf.sh /default-init
