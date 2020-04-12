#!/bin/bash
export LANG=C LC_ALL=C

while getopts 'u:' OPTION; do
  case "$OPTION" in
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
    IMAGE=$(docker ps | awk 'FNR >=2 {print $NF}' | grep ^$1 | head -1)
else 
    IMAGE=$(docker ps | awk 'FNR==2 {print $NF}')
fi

if [[ -z $IMAGE ]]; then
    echo "image not found"
    exit 1
else
    echo "Image: "$IMAGE
fi

if [ $# -ge 2 ]; then
    CMD=$2
else
    CMD=/bin/bash
fi

if [[ ! -z $user ]]; then
   args+=(-u)
   args+=($user)
fi

args+=($IMAGE)
args+=($CMD)

echo "running '"docker exec -it ${args[@]}"'"
exec docker exec -it ${args[@]}
