#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
pushd ../../OG-Platform
pushd examples/examples-simulated
mvn opengamma:server-stop -Dconfig=fullstack 
popd
git fetch upstream
git checkout develop
git rebase upstream/develop
git checkout asia-fixes
git rebase upstream/develop
mvn install -DskipTests
pushd examples/examples-simulated
mvn opengamma:server-start -Dconfig=fullstack
popd
popd
