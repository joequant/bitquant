#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR
. repos-info.sh
REPOS_SET="misc"
UPLOAD=0

for i in "$@"
do
    case $i in
	--upload)
	    UPLOAD=1
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

git config --global credential.helper cache

pushd ../.. > /dev/null
for repo in ${repos[$REPOS_SET]} ; do
    if [ -d "$repo" ]; then
	pushd $repo > /dev/null
	echo "Processing $repo"
	if [[ ${branch[$repo]} ]] ; then
	    mybranch=${branch[$repo]}
	else
	    mybranch="master"
	fi
	git branch $mybranch origin/$mybranch
	git checkout $mybranch
	if [[ ${upstream[$repo]} ]] ; then
	    git fetch upstream
	fi
	git fetch origin
	git stash
	if [[ ${upstream[$repo]} ]] ; then
	    git rebase upstream/$mybranch
	    if [ $UPLOAD -eq 1 ] ; then
		git push --set-upstream origin $mybranch
	    fi
	fi
	popd > /dev/null
    fi
done
popd > /dev/null
