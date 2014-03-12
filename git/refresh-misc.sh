#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
repos="JyNI XChange JSurface3D zipline etherpad-lite ethercalc"
cd $SCRIPT_DIR
if [ "$1" == "--upload" ] ; then
export UPLOAD=1
else
export UPLOAD=0
fi
git config --global credential.helper cache
declare -A branch
branch[XChange]="develop"
branch[etherpad-lite]="develop"

pushd ../.. > /dev/null
if [ -d Fudge-Python ]
then
pushd Fudge-Python > /dev/null
git pull origin
popd > /dev/null
fi

for repo in $repos
do
if [ -d $repo ]
then
pushd $repo > /dev/null
echo "Processing $repo"
if [[ ${branch[$repo]} ]]
then mybranch=${branch[$repo]}
else mybranch="master"
fi
git checkout $mybranch
git fetch upstream
git fetch origin
git stash
git rebase upstream/$mybranch
if [ $UPLOAD -eq 1 ] ; then git push --set-upstream origin $mybranch ; fi
popd > /dev/null
fi
done
popd > /dev/null











