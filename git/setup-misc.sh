#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
. $SCRIPT_DIR/repos-info.sh

pushd ../.. > /dev/null

for repo in $repos_misc ; do
if [ ! -d "$repo" ] 
then
git clone --progress https://github.com/$MY_NAME/$repo
pushd $repo > /dev/null
if [[ ${upstream[$repo]} ]]; then
git remote add upstream ${upstream[$repo]}
git fetch upstream
fi
git fetch origin
popd > /dev/null
else
echo "Repo $repo already present"
fi
done
popd > /dev/null


