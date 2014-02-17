#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR

pushd ../..
git clone https://github.com/$MY_NAME/OG-Platform
git clone https://github.com/$MY_NAME/OG-PlatformNative
git clone https://github.com/$MY_NAME/OG-Tools

pushd OG-Platform
git remote add upstream https://github.com/OpenGamma/OG-Platform
git fetch upstream
git fetch origin
git checkout -t origin/develop
git checkout bitquant
popd

pushd OG-PlatformNative
git remote add upstream https://github.com/OpenGamma/OG-PlatformNative
git fetch upstream
git fetch origin
git checkout -t origin/develop
git checkout bitquant
popd

pushd OG-Tools
git remote add upstream https://github.com/OpenGamma/OG-Tools
git fetch upstream
git fetch origin
popd
popd
