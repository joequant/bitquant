#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
cd $SCRIPT_DIR
./refresh-git.sh quantlib
