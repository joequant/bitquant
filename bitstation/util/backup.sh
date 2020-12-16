#!/bin/bash -f

DATE=$(date -u +'%Y%m%d.%H%M%S')
CMD=docker
dir=`pwd`
while getopts 'c:d:' OPTION; do
  case "$OPTION" in
    c)
      CMD="$OPTARG"
      ;;
    d)
	dir="$OPTARG"
	if [ ! -d $dir ] ; then
	    echo "cannot find directory $dir"
	    exit 1
	fi
	;;
    ?)
      echo "script usage: -c cmd image" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"
ID=${1:-bitstation}

pushd $dir
VOLUMES=$($CMD volume ls | awk 'FNR >=2 {print $NF}' | grep ^$ID)

for vol in $VOLUMES; do
    echo $vol
    $CMD run -v $vol:/volume --rm loomchild/volume-backup backup -c xz - > ${vol}.$DATE.tar.xz
done
popd
