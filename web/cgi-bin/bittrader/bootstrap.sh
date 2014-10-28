#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

# would like to set -e, but this causes odd errors
# set -e

echo "Content-type: text/html"
echo ""
echo "<pre>"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPT_DIR/environment.sh

if [ -e $LOG_DIR/bootstrap.done ] ; then
rm -f $LOG_DIR/bootstrap.done
rm -f $LOG_DIR/bootstrap.log
fi

(
flock -x -n 200 || exit 1
# Redirect STDERR to STDOUT
echo "Saving to <a href='/cgi-bin/bittrader/log/bootstrap' target='_blank'>log file</a>"
exec 6>&1
exec > $LOG_DIR/bootstrap.log
exec 2>&1
$WEB_DIR/scripts/bootstrap.sh
echo "Starting up servers"
$SCRIPT_DIR/servers.sh /on
touch $LOG_DIR/bootstrap.done
echo "(done)"
exec 1>&6
) 200> $LOG_DIR/bootstrap.lock &
echo "See progress in <a href='/cgi-bin/bittrader/log/bootstrap' target='_blank'>log file</a>" 
echo "</pre>"
