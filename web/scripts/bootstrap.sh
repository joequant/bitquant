#!/bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPT_DIR/environment.sh


echo "Running from directory $GIT_DIR as user "`whoami`
echo "Doing initial installation"
echo "Installing misc"
$GIT_DIR/git/setup-misc.sh
$GIT_DIR/git/rebuild-misc.sh
echo "Installing R packages"
$GIT_DIR/web/scripts/install-r-pkgs.sh
echo "Installing python packages"
$GIT_DIR/web/scripts/install-python.sh
echo "Installing npm packages"
$GIT_DIR/web/scripts/install-npm.sh

#set wiki conf
echo "Set up wiki"
sudo /usr/share/bitquant/conf.sh /wiki-unlock
sudo /usr/share/bitquant/conf.sh /wiki-init

echo "Set up ipython"
mkdir -p $MY_HOME/ipython
ln -s -f ../git/bitquant/web/home/ipython/examples $MY_HOME/ipython/examples

echo "Set up R"
mkdir -p $MY_HOME/R
cp -r $GIT_DIR/web/home/R/* $MY_HOME/R

# Refresh configurations
# This replaces the ajenti configuration with a 
# version that does not use ssl
sudo /usr/share/bitquant/conf.sh /default-init
