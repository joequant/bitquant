#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -e

pushd $SCRIPT_DIR > /dev/null
. ./setup-misc.sh 
. ./setup-og.sh 
#. ./setup-quantlib.sh
. ./rebuild-og.sh 
. ./init.og.sh
. ./rebuild-misc.sh 
popd > /dev/null
