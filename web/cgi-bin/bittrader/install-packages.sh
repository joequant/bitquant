#!/bin/bash

echo "Content-type: text/plain"
echo ""
set -e
SCRIPT_DIR=%SCRIPT_DIR%
echo "Running from directory $SCRIPT_DIR"
. $SCRIPT_DIR/../rpm/install-build-deps.sh
echo "Done"
