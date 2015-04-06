#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR
if [ "$1" == "--upload" ] ; then
export UPLOAD=1
else
export UPLOAD=0
fi


echo "Refreshing quantlib"
pushd ../.. > /dev/null
pushd quantlib > /dev/null
git fetch upstream
git fetch origin
git stash
git branch master origin/master
git checkout master
git rebase upstream/master
git checkout bitcoin
git rebase master
if [ $UPLOAD -eq 1 ] ; then git push --set-upstream origin master ; fi
popd > /dev/null
popd > /dev/null

