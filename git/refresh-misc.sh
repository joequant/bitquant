#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
. repos-info.sh
if [ "$1" == "--upload" ] ; then
export UPLOAD=1
else
export UPLOAD=0
fi
git config --global credential.helper cache

pushd ../.. > /dev/null
for repo in $repos_misc ; do
if [ -d "$repo" ]
then
pushd $repo > /dev/null
echo "Processing $repo"
if [[ ${branch[$repo]} ]]
then mybranch=${branch[$repo]}
else mybranch="master"
fi
git branch $mybranch origin/$mybranch
git checkout $mybranch
if [[ ${upstream[$repo]} ]] ; then
git fetch upstream
fi
git fetch origin
git stash
if [[ ${upstream[$repo]} ]] ; then
git rebase upstream/$mybranch
if [ $UPLOAD -eq 1 ] ; then git push --set-upstream origin $mybranch ; fi
fi
popd > /dev/null
fi
done
popd > /dev/null
