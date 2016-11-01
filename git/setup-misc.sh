#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
. $SCRIPT_DIR/repos-info.sh
pushd ../.. > /dev/null

DEVELOPER=0
REPOS_SET="misc"
for i in "$@"
do
    case $i in
	--dev)
	    echo "Developer mode"
	    DEVELOPER=1
	    shift
	    ;;
	*)
	    ;;
    esac
done

if [ $# -gt 0 ]; then
   echo "$1"
   REPOS_SET=$1
fi

for repo in ${repos[$REPOS_SET]} ; do
    if [ ! -d "$repo" ] ; then
	if [ $DEVELOPER -eq 1 ] ; then
	    git clone --progress https://github.com/$MY_NAME/$repo
	else
	    git clone --progress --single-branch --depth 1 https://github.com/$MY_NAME/$repo
	fi
	pushd $repo > /dev/null
	if [[ ${upstream[$repo]} ]]; then
	    git remote add upstream ${upstream[$repo]}
	    if [ $DEVELOPER -eq 1 ] ; then
		git fetch upstream
	    fi
	fi
	if [ $DEVELOPER -eq 1 ] ; then
	    git fetch origin
	fi
	popd > /dev/null
    else
	echo "Repo $repo already present"
    fi
done
popd > /dev/null


