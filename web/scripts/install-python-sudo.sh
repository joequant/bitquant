#!/bin/bash
# sudo portion of python package installations

echo "Running python installation"
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $ROOT_SCRIPT_DIR/rootcheck.sh
SCRIPT_DIR=$1
ME=$2

for packages in zipline vispy pyalgotrade statsmodels quandl \
patsy beautifulsoup4 pymongo sympy ipython_mongo ;
do pip3 install --upgrade $packages ;
done
