#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_DIR=$SCRIPT_DIR/..
config=${1-bitstation}

pushd $WEB_DIR > /dev/null
if [ ! -d $config ] ; then
echo "Config $config not present"
exit 1
else
echo "Using config $config"
fi
popd > /dev/null

