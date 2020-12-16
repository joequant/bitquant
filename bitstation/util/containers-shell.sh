#!/bin/bash
export LANG=C LC_ALL=C
CMD=docker
VERBOSE=0
while getopts 'c:u:v' OPTION; do
  case "$OPTION" in
    c)
      CMD="$OPTARG"
      ;;
    u)
      user="$OPTARG"
      ;;
    v)
	VERBOSE=1
	;;
    ?)
      echo "script usage: -u usernae image cmd" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

args=()

if [ $# -ge 1 ]; then
    IMAGE=$($CMD ps | awk 'FNR >=2 {print $NF}' | grep ^$1 | head -1)
else 
    IMAGE=$($CMD ps | awk 'FNR==2 {print $NF}')
fi

if [[ -z $IMAGE ]]; then
    echo "image not found"
    exit 1
elif [ $VERBOSE -eq 1 ] ; then
    echo "Image: "$IMAGE
fi

if [ -t 1 ] ; then
    args+=(-it)
fi

if [[ ! -z $user ]]; then
   args+=(-u)
   args+=($user)
fi

args+=($IMAGE)

if [ $# -ge 2 ]; then
    shift
    args+=($@)
else
    args+=("/bin/bash")
fi



if [ $VERBOSE -eq 1 ] ; then
    echo "running '"$CMD exec ${args[@]}"'"
fi
exec $CMD exec ${args[@]}
