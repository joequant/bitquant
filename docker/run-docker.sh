#!/bin/bash

IMAGE=bitstation
if [ "$1" != "" ] ; then
   IMAGE=$1
fi

sudo echo

mkdir -p ~/volumes/bitstation
pushd ~/volumes/bitstation


if [ ! -e ~/volumes/bitstation/home ] ; then
id=$(sudo docker create $IMAGE)
sudo docker cp $id:/home - | tar xf -
sudo docker rm -v $id
fi


if [ ! -e ~/volumes/bitstation/var/log ] ; then
mkdir -p var/log
chmod a+rwx var/log
sudo docker run \
-v ~/volumes/bitstation/var:/mnt \
$IMAGE \
cp -a -P -R /var/log /mnt
fi

if [ ! -e ~/volumes/bitstation/var/lib ] ; then
mkdir -p var/lib
chmod a+rwx var/lib
fi

for app in dokuwiki mongodb ; do
if [ ! -e ~/volumes/bitstation/var/lib/$app ] ; then
sudo docker run \
-v ~/volumes/bitstation/var/lib:/mnt \
$IMAGE \
cp -a -P -R /var/lib/$app /mnt
fi
done


popd
sudo systemctl stop httpd
# Reset firewall rules
sudo systemctl restart docker
sudo docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v ~/volumes/bitstation/home:/home \
-v ~/volumes/bitstation/var/lib/dokuwiki:/var/lib/dokuwiki \
-v ~/volumes/bitstation/var/lib/mongodb:/var/lib/mongodb \
-v ~/volumes/bitstation/var/log:/var/log \
-p 80:80 -p 443:443 $IMAGE
