#!/bin/bash
config=${1-bitstation}

if [ ! -d $config ] ; then
echo "Config $config not present"
exit 1
else
echo "Using config $config"
fi
