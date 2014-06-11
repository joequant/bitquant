#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR

pushd ../..
rm -rf ethercalc OG-Platform OG-PlatformNative \
   OG-Tools quantlib bitquant/web/log/bootstrap.done
popd
