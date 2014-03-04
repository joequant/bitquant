#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR

echo "Refreshing quantlib"
pushd ../.. > /dev/null
pushd quantlib > /dev/null
git fetch upstream
git fetch origin
git stash
git checkout master
git rebase upstream/master
git push --set-upstream origin master
popd > /dev/null
popd > /dev/null

