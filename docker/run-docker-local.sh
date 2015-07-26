#!/bin/bash

IMAGE=bitstation
if [ "$1" != "" ] ; then
   IMAGE=$1
fi

if [ ! -e ~/volumes/bitstation ] ; then
mkdir -p ~/volumes/bitstation
pushd ~/volumes/bitstation
sudo systemctl stop httpd
id=$(sudo docker create $IMAGE)
sudo docker cp $id:/home - | tar xf -
mkdir -p var/lib
pushd var/lib
sudo docker cp $id:/var/lib/dokuwiki - | tar xf -
sudo docker run \
-v ~/volumes/bitstation/var/lib/dokuwiki:/var/lib/dokuwiki \
$IMAGE \
chown -R apache:apache /var/lib/dokuwiki
popd
sudo docker rm -v $id
popd
fi

sudo systemctl stop httpd
sudo docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v ~/volumes/bitstation/home:/home \
-v ~/volumes/bitstation/var/lib/dokuwiki:/var/lib/dokuwiki \
-p 80:80 -p 443:443 $IMAGE
