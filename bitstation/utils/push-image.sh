#!/bin/bash -f
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $SCRIPT_DIR
./containers.sh down
docker tag joequant/bitstation:production joequant/bitstation:latest
docker tag joequant/nextcloud:production joequant/nextcloud:latest
./rm-stopped-containers.sh
./rm-untagged-images.sh
skopeo copy containers-storage:localhost/joequant/bitstation  docker-daemon:joequant/bitstation:latest
./containers.sh up
popd
