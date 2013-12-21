#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR

pushd ../..
pushd XChange
git fetch upstream
git fetch origin
git stash
git checkout master
git rebase upstream/master
git push --set-upstream origin master
popd

pushd JSurface3D
git fetch upstream
git fetch origin
git stash
git checkout master
git rebase upstream/master
git push --set-upstream origin master
popd

pushd zipline
git fetch upstream
git fetch origin
git stash
git checkout master
git rebase upstream/master
git push --set-upstream origin master
popd

pushd aiotrade
git fetch upstream
git fetch origin
git stash
git checkout master
git rebase upstream/master
git push --set-upstream origin master
popd


