#!/bin/bash -v

sudo systemctl restart httpd
#ipython notebook &

if [ -d ../../OG-Platform ] ; then
pushd ../../OG-Platform/examples/examples-simulated/
mvn install
mvn opengamma:server-start -Dconfig=fullstack
popd
fi

if [ -d ../../ethercalc ] ; then
pushd ../../ethercalc
make &
popd
fi

if [ -d ../../etherpad-lite ] ; then
pushd ../../etherpad-lite
bin/run.sh &
popd
fi




