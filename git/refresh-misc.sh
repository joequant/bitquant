#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
repos="JyNI XChange JSurface3D zipline etherpad-lite ethercalc"
cd $SCRIPT_DIR
git config --global credential.helper cache
declare -A branch
branch[XChange]="develop"
branch[etherpad-lite]="develop"

pushd ../..
if [ -d Fudge-Python ]
then
pushd Fudge-Python
git pull origin
popd
fi

for repo in $repos
do
if [ -d $repo ]
then
pushd $repo
if [[ ${branch[$repo]} ]]
then mybranch=${branch[$repo]}
else mybranch="master"
fi
git checkout $mybranch
git fetch upstream
git fetch origin
git stash
git rebase upstream/$mybranch
git push --set-upstream origin $mybranch
popd
fi
done
popd











