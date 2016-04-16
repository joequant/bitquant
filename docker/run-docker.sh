#!/bin/bash

IMAGE=joequant/bitstation
if [ "$1" != "" ] ; then
   IMAGE=$1
fi

$SUDO docker run $IMAGE echo 
mkdir -p ~/volumes/bitstation
pushd ~/volumes/bitstation
mkdir -p var/lib
chmod a+rwx var
chmod a+rwx var/lib

if [ ! -e ~/volumes/bitstation/home ] ; then
# This will fail on docker < 1.8
id=$($SUDO docker create $IMAGE)
$SUDO docker cp $id:/home - | tar xf -
$SUDO docker rm -v $id
fi

if [ ! -e ~/volumes/bitstation/var/log ] ; then
mkdir -p var/log
chmod a+rwx var/log
$SUDO docker run \
-v ~/volumes/bitstation/var:/mnt \
$IMAGE \
cp -a -P -R /var/log /mnt
fi

if [ ! -e ~/volumes/bitstation/etc ] ; then
mkdir -p etc
chmod a+rwx etc
$SUDO docker run \
-v ~/volumes/bitstation:/mnt \
$IMAGE \
cp -a -P -R /etc /mnt
fi

root=var/lib
for app in dokuwiki mongodb redis ; do
if [ ! -e ~/volumes/bitstation/$root/$app ] ; then
$SUDO docker run \
-v ~/volumes/bitstation/$root:/mnt \
$IMAGE \
cp -a -P -R /$root/$app /mnt
fi
done

root=home/user/.local/share/jupyter/kernels
for app in redis ; do
if [ ! -e ~/volumes/bitstation/$root/$app ] ; then
$SUDO docker run \
-v ~/volumes/bitstation/$root:/mnt \
$IMAGE \
cp -a -P -R /$root/$app /mnt
fi
done


popd

$SUDO docker run -i \
--privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v ~/volumes/bitstation/home:/home \
-v ~/volumes/bitstation/var/lib/dokuwiki:/var/lib/dokuwiki \
-v ~/volumes/bitstation/var/lib/mongodb:/var/lib/mongodb \
-v ~/volumes/bitstation/var/lib/redis:/var/lib/redis \
-v ~/volumes/bitstation/var/log:/var/log \
-v ~/volumes/bitstation/etc:/etc \
-p 80:80 -p 443:443 $IMAGE >& docker.log &
echo "Docker started"

