#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git
if [ $# -eq 1 ] ; then
export PATH_INFO=$1
else 
echo "Content-type: text/html"
echo ""
fi
echo "<pre>"
if [ "$PATH_INFO" == "/on" ] ; then
sudo systemctl enable bitquant 2>&1 
sudo systemctl start bitquant 2>&1 
sudo systemctl enable shiny-server 2>&1
sudo systemctl start shiny-server 2>&1
echo "Bitquant servers enabled"
elif [ "$PATH_INFO" == "/off" ] ; then
sudo systemctl stop bitquant 2>&1 
sudo systemctl disable bitquant 2>&1 
sudo systemctl stop shiny-server 2>&1
sudo systemctl disable shiny-server 2>&1
echo "Bitquant servers disabled"
else
echo "unknown path $PATH_INFO"
fi

echo "</pre>"
