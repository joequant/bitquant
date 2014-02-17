#!/bin/bash

sudo systemctl stop httpd
#ipython notebook &

if [ -d ../../OG-Platform ] ; then
pushd ../../OG-Platform/examples/examples-simulated/
mvn opengamma:server-stop -Dconfig=fullstack
popd
fi

killall node



