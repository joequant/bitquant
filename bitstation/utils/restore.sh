#!/bin/bash
CMD=docker

while getopts 'c:' OPTION; do
  case "$OPTION" in
    c)
      CMD="$OPTARG"
      ;;
    ?)
      echo "script usage: -c cmd image" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"
ID=${1}

IFS='.'
read -ra ARR <<< $(basename "$ID")
IFS=' '

volname="${ARR[0]}"
compression="${ARR[-1]}"

echo "Moving ${1} into ${volname}"

cat  $1 |  $CMD run -i -v $volname:/volume --rm loomchild/volume-backup restore -c $compression -
#cat demo_home.20200503.113330.tar.xz  | tar -J -tf -

