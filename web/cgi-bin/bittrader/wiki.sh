#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export HOME=/home/`whoami`
WEB_DIR=$HOME/git/bitquant/web
LOG_DIR=$WEB_DIR/log

if [ $# -ge 1 ] ; then
export PATH_INFO=$1
else
echo "Content-type: text/html"
echo ""
fi
echo "<pre>"
if [ "$PATH_INFO" == "/conf" ] ; then
if [ $# -eq 2 ] ; then
sudo cp $WEB_DIR/dokuwiki/conf/$2/* /etc/dokuwiki 2>&1
fi
echo "Wiki switch to conf $2"
elif [ "$PATH_INFO" == "/init" ] ; then
sudo cp -r -f $WEB_DIR/dokuwiki/pages/* /var/lib/dokuwiki/pages
sudo chown -R apache:apache /var/lib/dokuwiki/pages
echo "Wiki page init"
elif [ "$PATH_INFO" == "/adduser" ] ; then 
if [ $# -eq 2 ] ; then
echo "$2" | sudo tee -a /etc/dokuwiki/users.auth.php > /dev/null
fi
echo "User added"
else
echo "unknown path $PATH_INFO"
fi

echo "</pre>"
