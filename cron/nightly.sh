#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
pushd ../../OG-Platform
pushd examples/examples-simulated
mvn opengamma:server-stop -Dconfig=fullstack
popd
git fetch upstream
git rebase upstream/develop
mvn install 
pushd examples/examples-simulated
mvn opengamma:server-start -Dconfig=fullstack
popd
popd
