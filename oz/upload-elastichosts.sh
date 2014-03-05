#!/bin/bash

# Modified to read in config file

if [ -e $HOME/bitquant.conf ] ;  then
echo "Reading configuration from $HOME/bitquant.conf"
. $HOME/bitquant.conf
else
echo "No configuration found.  Please install bitquant.conf.example"
fi

set +o posix
shopt -s extglob

die() {
  echo "$@" >&2
  exit 1
}

usage() {
  cat >&2 <<EOF
Usage: $0 [ OPTIONS ] FILENAME | BLOCK-DEVICE
Options:
  -c CHUNK       size of chunks (default: 4194304)
  -d DRIVE-UUID  UUID of existing drive to image (default: creates new drive)
  -n NAME        name for newly created drive (default: basename of FILENAME)
  -o OFFSET      byte offset from which to resume upload (default: 0)
EOF
  exit 1
}

if ! type -t curl >/dev/null; then
  die "This tool requires curl, available from http://curl.haxx.se/"
fi

[ -n "$EHURI" ] || die "Please set EHURI=<API endpoint URI>"
[ -n "$EHAUTH" ] || die "Please set EHAUTH=<user uuid>:<secret API key>"

CHUNK=4194304
OFFSET=0
unset DRIVE

while getopts c:d:n:o: OPTION; do
  case "$OPTION" in
    c)
      case "$OPTARG" in
        [1-9]*([0-9]))
          CHUNK="$OPTARG"
          ;;
        *)
          usage
          ;;
      esac
      ;;
    d)
      DRIVE="$OPTARG"
      ;;
    n)
      NAME="$OPTARG"
      ;;
    o)
      case "$OPTARG" in
        0|[1-9]*([0-9]))
          OFFSET="$OPTARG"
          ;;
        *)
          usage
          ;;
      esac
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))
[ $# -eq 1 ] || usage

NAME="${NAME:-`basename "$1"`}"

[ -f "$1" ] && SIZE=`wc -c < "$1"`
[ -b "$1" ] && SIZE=`blockdev --getsize64 "$1"`
[ -n "$SIZE" ] && [ $SIZE -gt 0 ] || die "$1: No such file or directory"

EHAUTH="user = \"$EHAUTH\""

if [ -n "$DRIVE" ]; then
  echo "Using existing drive $DRIVE"
elif POSTDATA=`echo "name $NAME"; echo "size $SIZE"` \
  && DRIVE=`curl --data-ascii "$POSTDATA" -K <(echo "$EHAUTH") -f -s \
                 -H 'Content-Type: text/plain' -H 'Expect:' \
                 "${EHURI%/}/drives/create"` \
  && DRIVE=`sed -n 's/^drive  *//p' <<< "$DRIVE"` && [ -n "$DRIVE" ]; then
  echo "Created drive $DRIVE of size $SIZE"
else
  die "Failed to create drive of size $SIZE"
fi

COUNT=$(((SIZE - OFFSET + CHUNK - 1)/CHUNK))
echo -n "Uploading $COUNT chunks of $CHUNK bytes: "

( dd bs=$CHUNK count=0 skip=$((OFFSET/CHUNK)) 2>/dev/null
  for ((OFFSET = OFFSET/CHUNK; OFFSET*CHUNK < SIZE; OFFSET++)); do
    head -c $CHUNK | gzip -c \
      | curl --data-binary @- -K <(echo "$EHAUTH") -f -s \
             -H 'Content-Type: application/octet-stream' \
             -H 'Content-Encoding: gzip' -H 'Expect:' \
             "${EHURI%/}/drives/$DRIVE/write/$((OFFSET*CHUNK))"
    [ $? -eq 0 ] && echo -n . && continue || echo E
    cat <<EOF >&2
Failed to write chunk $OFFSET of $COUNT: aborting
Restart with '-d $DRIVE -o $((OFFSET*CHUNK))' to resume the upload
EOF
    exit 1
  done
  echo " completed"
) < "$1"
