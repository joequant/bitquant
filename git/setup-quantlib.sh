#!/bin/bash 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant

pushd $SCRIPT_DIR/../.. > /dev/null
if [ ! -d quantlib ] ; then
git clone --progress https://github.com/$MY_NAME/quantlib
pushd quantlib > /dev/null
git remote add upstream https://github.com/lballabio/quantlib
git fetch upstream
git fetch origin
popd > /dev/null
else
echo "Repo quantlib already present"
fi
popd > /dev/null

