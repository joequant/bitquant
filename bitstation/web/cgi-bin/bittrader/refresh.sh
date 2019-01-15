#!/bin/bash 
echo "Content-type: text/plain"
echo ""
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
python3 $SCRIPT_DIR/model.py refresh-scripts
