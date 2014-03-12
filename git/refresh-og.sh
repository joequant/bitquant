#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR
if [ "$1" == "--upload" ] ; then
export UPLOAD=1
else
export UPLOAD=0
fi

pushd ../..
pushd OG-PlatformNative
git fetch upstream
git fetch origin
git stash
git checkout master
git rebase upstream/master
if [ $UPLOAD -eq 1 ] ; then git push --set-upstream origin master ; fi
git checkout develop
git rebase upstream/develop
if [ $UPLOAD -eq 1 ] ; then git push --set-upstream origin develop ; fi
git checkout bitquant
git rebase origin/bitquant
git rebase upstream/develop
if [ $UPLOAD -eq 1 ] ; then git push --force --set-upstream origin bitquant ; fi
popd

pushd OG-Platform
git fetch upstream
git fetch origin
git stash
git checkout master
git rebase upstream/master
if [ $UPLOAD -eq 1 ] ; then git push --set-upstream origin master ; fi
git checkout develop
git rebase upstream/develop
if [ $UPLOAD -eq 1 ] ; then git push --set-upstream origin develop ; fi
git checkout bitquant
git rebase origin/bitquant
git rebase upstream/develop
if [ $UPLOAD -eq 1 ] ; then git push --force --set-upstream origin bitquant ; fi
popd
