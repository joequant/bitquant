#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR

pushd ../..
pushd quantlib
git fetch upstream
git fetch origin
git stash
git checkout master
git rebase upstream/master
git push --set-upstream origin master
popd
popd
