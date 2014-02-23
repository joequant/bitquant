#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $SCRIPT_DIR
./setup-misc.sh
./setup-og.sh
./setup-quantlib.sh
./rebuild-og.sh
./rebuild-misc.sh
popd
