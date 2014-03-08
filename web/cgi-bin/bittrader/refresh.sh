#!/bin/bash 
echo "Content-type: text/plain"
echo ""
echo "Refresh scripts"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ME=`stat -c "%U" ${BASH_SOURCE[0]}`
GROUP=`stat -c "%G" ${BASH_SOURCE[0]}`
export HOME=/home/`whoami`
GIT_DIR=$HOME/git/bitquant

cp $GIT_DIR/web/cgi-bin/bittrader/*.sh /var/www/cgi-bin/bittrader
cp $GIT_DIR/web/cgi-bin/bittrader/*.py /var/www/cgi-bin/bittrader
echo "Done"
