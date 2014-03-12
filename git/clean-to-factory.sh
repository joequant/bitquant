#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR

pushd ../..
rm -rf ethercalc etherpad-lite OG-Platform OG-PlatformNative \
   OG-Tools JSurface3D quantlib bitquant/web/bootstrap.done
popd
