#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
. ../web/norootcheck.sh
pushd ../../OG-Platform  > /dev/null
mvn install -Dmaven.test.skip=True
pushd examples/examples-simulated > /dev/null
mvn opengamma:server-stop -Dconfig=fullstack
mvn opengamma:server-init -Dconfig=fullstack
mvn opengamma:server-start -Dconfig=fullstack
popd > /dev/null
popd > /dev/null

pushd ../../OG-PlatformNative > /dev/null
mvn install -Dmaven.test.skip=True
popd > /dev/null

