#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR

pushd ../..
pushd OG-PlatformNative
git fetch upstream
git fetch origin
git stash
git checkout master
git rebase upstream/master
git push --set-upstream origin master
git checkout develop
git rebase upstream/develop
git push --set-upstream origin develop
git checkout asia-fixes
git rebase origin/asia-fixes
git rebase upstream/develop
git push --force --set-upstream origin asia-fixes
git checkout bitquant
git rebase origin/bitquant
git rebase upstream/develop
git push --force --set-upstream origin bitquant
popd

pushd OG-Platform
git fetch upstream
git fetch origin
git checkout develop
git rebase upstream/develop
git checkout asia-fixes
git rebase upstream/develop
git push --set-upstream origin master
git push --set-upstream origin develop
git checkout asia-fixes
git rebase origin/asia-fixes
git rebase upstream/develop
git push --force --set-upstream origin asia-fixes
git checkout bitquant
git rebase origin/bitquant
git rebase upstream/develop
git push --force --set-upstream origin bitquant
popd
