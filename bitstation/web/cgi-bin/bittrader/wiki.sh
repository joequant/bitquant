#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPT_DIR/environment.sh

if [ $# -ge 1 ] ; then
export PATH_INFO=$1
else
echo "Content-type: text/html"
echo ""
fi
echo "<pre>"
if [ "$PATH_INFO" == "/rmuser" ] ; then 
if [ $# -eq 2 ] ; then
grep -v "$2:" /etc/dokuwiki/users.auth.php > /tmp/users.auth.php
sudo cp /tmp/users.auth.php /etc/dokuwiki/users.auth.php
sudo chown -R apache:apache /etc/dokuwiki/users.auth.php
fi
echo "User removed $2"
elif [ "$PATH_INFO" == "/adduser" ] ; then 
if [ $# -eq 2 ] ; then
echo "$2" | sudo tee -a /etc/dokuwiki/users.auth.php > /dev/null
fi
echo "User added"
else
echo "unknown path $PATH_INFO"
fi

echo "</pre>"
