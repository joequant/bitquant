#!/bin/bash 
echo "Content-type: text/plain"
echo ""
echo "Refresh scripts"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ME=`stat -c "%U" $SCRIPT_DIR/setup.sh`
GROUP=`stat -c "%G" $SCRIPT_DIR/setup.sh`
export HOME=/home/`whoami`
GIT_DIR=$HOME/git/bitquant

cp $GIT_DIR/cgi-bin/bittrader/*.sh /var/www/cgi-bin/bittrader
echo "Done"
