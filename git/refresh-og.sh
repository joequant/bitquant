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
for repo in OG-Platform OG-PlatformNative ; do
echo "Processing $repo"
pushd $repo > /dev/null
git fetch upstream
git fetch origin
git stash
git branch master origin/master
git checkout master
git rebase upstream/master
if [ $UPLOAD -eq 1 ] ; then git push --set-upstream origin master ; fi
git branch develop origin/develop
git checkout develop
git rebase upstream/develop
if [ $UPLOAD -eq 1 ] ; then git push --set-upstream origin develop ; fi
git branch bitquant origin/bitquant
git checkout bitquant
git rebase origin/bitquant
git rebase upstream/develop
if [ $UPLOAD -eq 1 ] ; then git push --force --set-upstream origin bitquant ; fi
popd > /dev/null
done

for repo in OG-Tools ; do
echo "Processing $repo"
pushd $repo > /dev/null
git fetch upstream
git fetch origin
git stash
git checkout master
git rebase upstream/master
if [ $UPLOAD -eq 1 ] ; then git push --set-upstream origin master ; fi
popd > /dev/null
done

popd

