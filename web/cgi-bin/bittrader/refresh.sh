#!/bin/bash 
echo "Content-type: text/plain"
echo ""
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
python $SCRIPT_DIR/info.py refresh-scripts
