#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export HOME=/home/`whoami`
WEB_DIR=$HOME/git/bitquant/web
LOG_DIR=$WEB_DIR/log

if [ $# -eq 1 ] ; then
export PATH_INFO=$1
else 
echo "Content-type: text/html"
echo ""
fi
echo "<pre>"
if [ "$PATH_INFO" == "/lock" ] ; then
cp $WEB_DIR/dokuwiki/lock/* /etc/dokuwiki
echo "Wiki locked"
elif [ "$PATH_INFO" == "/unlock" ] ; then
cp $WEB_DIR/dokuwiki/unlock/* /etc/dokuwiki
echo "Wiki unlocked"
else
echo "unknown path $PATH_INFO"
fi

echo "</pre>"
