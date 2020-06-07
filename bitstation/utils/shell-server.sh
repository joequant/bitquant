#!/bin/bash
export LANG=C LC_ALL=C
CMD=docker
while getopts 'c:u:' OPTION; do
  case "$OPTION" in
    c)
      CMD="$OPTARG"
      ;;
    u)
      user="$OPTARG"
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
else
    echo "Image: "$IMAGE
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




echo "running '"$CMD exec -it ${args[@]}"'"
exec $CMD exec -it ${args[@]}
