#!/bin/bash

IMAGE=joequant/bitstation
if [ "$1" != "" ] ; then
   IMAGE=$1
fi

if [ "$BTQNT_IMAGE_DIR" == "" ] ; then
    BTQNT_IMAGE_DIR=~/volumes/bitstation
fi

$SUDO docker run $IMAGE echo 
mkdir -p $BTQNT_IMAGE_DIR
pushd $BTQNT_IMAGE_DIR
mkdir -p var/lib
chmod a+rwx var
chmod a+rwx var/lib

if [ ! -e $BTQNT_IMAGE_DIR/home ] ; then
# This will fail on docker < 1.8
id=$($SUDO docker create $IMAGE)
$SUDO docker cp $id:/home - | tar xf -
$SUDO docker rm -v $id
fi

if [ ! -e $BTQNT_IMAGE_DIR/var/log ] ; then
mkdir -p var/log
chmod a+rwx var/log
$SUDO docker run \
-v $BTQNT_IMAGE_DIR/var:/mnt \
$IMAGE \
cp -a -P -R /var/log /mnt
fi

if [ ! -e $BTQNT_IMAGE_DIR/etc ] ; then
mkdir -p etc
chmod a+rwx etc
$SUDO docker run \
-v $BTQNT_IMAGE_DIR:/mnt \
$IMAGE \
cp -a -P -R /etc /mnt
fi

root=var/lib
for app in dokuwiki mongodb redis ; do
if [ ! -e $BTQNT_IMAGE_DIR/$root/$app ] ; then
$SUDO docker run \
-v $BTQNT_IMAGE_DIR/$root:/mnt \
$IMAGE \
cp -a -P -R /$root/$app /mnt
fi
done

root=home/user/.local/share/jupyter/kernels
for app in redis ; do
if [ ! -e $BTQNT_IMAGE_DIR/$root/$app ] ; then
$SUDO docker run \
-v $BTQNT_IMAGE_DIR/$root:/mnt \
$IMAGE \
cp -a -P -R /$root/$app /mnt
fi
done


popd

$SUDO docker run -i \
--privileged --init \
-v $BTQNT_IMAGE_DIR/home:/home \
-v $BTQNT_IMAGE_DIR/var/lib/dokuwiki:/var/lib/dokuwiki \
-v $BTQNT_IMAGE_DIR/var/lib/mongodb:/var/lib/mongodb \
-v $BTQNT_IMAGE_DIR/var/lib/redis:/var/lib/redis \
-v $BTQNT_IMAGE_DIR/var/log:/var/log \
-v $BTQNT_IMAGE_DIR/etc:/etc \
-p 80:80 -p 443:443 $IMAGE >& docker.log &
echo "Docker started"

