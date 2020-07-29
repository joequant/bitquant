#!/bin/bash -f
# This script moves the latest podman image to docker.  This is because
# the docker image is on a disk limited volume.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGES=demo
pushd $SCRIPT_DIR
./containers.sh down $IMAGES
docker tag joequant/bitstation:production joequant/bitstation:latest
docker tag joequant/nextcloud:production joequant/nextcloud:latest
./rm-stopped-containers.sh
./rm-untagged-images.sh
skopeo copy containers-storage:localhost/joequant/bitstation  docker-daemon:joequant/bitstation:latest
./containers.sh up $IMAGES
popd
