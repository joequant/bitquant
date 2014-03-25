#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR

pushd ../.. > /dev/null

for repo in OG-Platform OG-PlatformNative ; do
if [ ! -d $repo ] ; then
git clone --progress https://github.com/$MY_NAME/$repo
pushd $repo > /dev/null
git remote add upstream https://github.com/OpenGamma/$repo
git fetch upstream
git fetch origin
git checkout -t origin/develop
git checkout bitquant
popd > /dev/null
else
echo "Repo $repo  already present"
fi
done

if [ ! -d OG-Tools ] ; then
git clone https://github.com/$MY_NAME/OG-Tools
pushd OG-Tools > /dev/null
git remote add upstream https://github.com/OpenGamma/OG-Tools
git fetch upstream
git fetch origin
popd > /dev/null
else
echo "Repo OG-Tools already present"
fi

popd > /dev/null
