#!/bin/bash

IMAGE=bitstation
if [ "$1" != "" ] ; then
   IMAGE=$1
fi

mkdir -p ~/volumes/bitstation
pushd ~/volumes/bitstation
id=$(sudo docker create $IMAGE)

if [ ! -e ~/volumes/bitstation/home ] ; then
sudo docker cp $id:/home - | tar xf -
fi

if [ ! -e ~/volumes/bitstation/var/lib/dokuwiki ] ; then
mkdir -p var/lib
pushd var/lib
sudo docker cp $id:/var/lib/dokuwiki - | tar xf -
sudo docker run \
-v ~/volumes/bitstation/var/lib/dokuwiki:/var/lib/dokuwiki \
$IMAGE \
chown -R apache:apache /var/lib/dokuwiki
popd
fi

if [ ! -e ~/volumes/bitstation/var/log ] ; then
mkdir -p var
pushd var
sudo docker cp $id:/var/log - | tar xf -
popd
fi

sudo docker rm -v $id
popd
sudo systemctl stop httpd
# Reset firewall rules
sudo systemctl restart docker
sudo docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v ~/volumes/bitstation/home:/home \
-v ~/volumes/bitstation/var/lib/dokuwiki:/var/lib/dokuwiki \
-v ~/volumes/bitstation/var/log:/var/log \
-p 80:80 -p 443:443 $IMAGE
