#!/bin/bash -v

sudo systemctl stop httpd
#ipython notebook &

if [ -d ../../OG-Platform ] ; then
pushd ../../OG-Platform/examples/examples-bitquant/
mvn opengamma:server-stop -Dconfig=fullstack
popd
fi

killall node



