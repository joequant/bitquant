#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
pushd ../../OG-Platform
git stash
git checkout asia-fixes
pushd examples/examples-simulated
mvn opengamma:server-stop -Dconfig=fullstack 
popd
git stash
git fetch upstream
git fetch origin
git checkout develop
git rebase origin/develop
git rebase upstream/develop
git checkout asia-fixes
git rebase origin/asia-fixes
git rebase upstream/develop
mvn install -DskipTests
pushd examples/examples-simulated
mvn opengamma:server-init -Dconfig=fullstack
mvn opengamma:server-start -Dconfig=fullstack
popd
popd
