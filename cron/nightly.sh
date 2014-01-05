#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
pushd ../../OG-Platform
pushd examples/examples-simulated
mvn opengamma:server-stop -Dconfig=fullstack 
popd
mvn install -Dmaven.test.skip=True
pushd examples/examples-simulated
mvn opengamma:server-init -Dconfig=fullstack
mvn opengamma:server-start -Dconfig=fullstack
popd
popd

pushd ../../OG-PlatformNative
mvn install -Dmaven.test.skip=True
popd
