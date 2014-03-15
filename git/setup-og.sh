#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR

pushd ../.. > /dev/null

if [ ! -d OG-Platform ] ; then
git clone --progress https://github.com/$MY_NAME/OG-Platform
pushd OG-Platform > /dev/null
git remote add upstream https://github.com/OpenGamma/OG-Platform
git fetch upstream
git fetch origin
git checkout -t origin/develop
git checkout bitquant
popd > /dev/null
else
echo "Repo OG-Platform  already present"
fi

if [ ! -d OG-PlatformNative ] ; then
git clone --progress https://github.com/$MY_NAME/OG-PlatformNative
pushd OG-PlatformNative > /dev/null
git remote add upstream https://github.com/OpenGamma/OG-PlatformNative
git fetch upstream
git fetch origin
git checkout -t origin/develop
git checkout bitquant
popd > /dev/null
else
echo "Repo OG-Platform Native already present"
fi

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
