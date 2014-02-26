#!/bin/bash

echo "Content-type: text/plain"
echo ""
set -e
SCRIPT_DIR="$( cd "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd )"
echo "Running from directory $SCRIPT_DIR"
. $SCRIPT_DIR/../../git/bootstrap.sh
