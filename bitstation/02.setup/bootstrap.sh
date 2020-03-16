#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ME=user
GROUP=user
MY_HOME=$(eval echo ~$ME)

pushd $MY_HOME
# needed for building ethercalc
USERPROFILE=$MY_HOME
export HOME=$MY_HOME
GIT_DIR=$MY_HOME/git/bitquant
WEB_DIR=$MY_HOME/git/bitquant/bitstation/web
LOG_DIR=$WEB_DIR/log
. /tmp/proxy.sh

echo "Running from directory $GIT_DIR as user "`whoami`
echo "Doing initial installation"
echo "Installing misc"
$GIT_DIR/git/setup-git.sh misc

# install python first so that ijavascript dependencies
# are met
echo "Installing npm packages"
if [ -d /home/user/git/etherpad-lite ] ; then
pushd /home/user/git/etherpad-lite
make
if [ -d src/node_modules ] ; then
pushd src/node_modules
modclean -r
popd
fi
popd
fi


echo "Set up ipython"
mkdir -p $MY_HOME/ipython
cp -r $WEB_DIR/home/examples $MY_HOME/examples

echo "Set up R"
mkdir -p $MY_HOME/R
cp -r $WEB_DIR/home/R/* $MY_HOME/R
popd
