#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
. repos-info.sh

if [ "$#" != "1" ] ; then
echo "incorrect number of args $#"
exit 1
fi

tag=$1
echo "Tag $1"

pushd ../.. > /dev/null
for repo in bitquant $repos_misc $repos_quantlib $repos_og ; do
pushd $repo > /dev/null
git tag $tag -m \"bitquant tag\"
git push origin $tag
popd
done
popd > /dev/null
