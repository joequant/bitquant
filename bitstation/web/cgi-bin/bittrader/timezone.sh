#!/bin/bash
if [ $# -eq 1 ] ; then
TZ=$1
fi

if [ "$TZ" != "" ] ; then
sudo /bin/timedatectl set-timezone $TZ
echo "New timezone "`/bin/timedatectl | grep Timezone:`
fi

