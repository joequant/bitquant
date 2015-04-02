#!/bin/bash
# sudo portion of python package installations

echo "Running python installation"
ROOT_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $ROOT_SCRIPT_DIR/rootcheck.sh
SCRIPT_DIR=$1
ME=$2

# put yelp_uri in back to override downloaded version
for repo in pyswagger ;
do
echo /home/$ME/git/$repo
if [ -d /home/$ME/git/$repo ] ; then
pushd /home/$ME/git/$repo > /dev/null
python3 setup.py clean
python3 setup.py install --force
python3 setup.py clean
popd > /dev/null
fi
done
