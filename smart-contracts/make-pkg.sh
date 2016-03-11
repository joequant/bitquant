#!/bin/bash

ITEM=$1
DATE=`date +'%Y%m%d'`
DIR=$ITEM-$DATE

if [ -e ~/$DIR.zip ] ; then
    echo "package already exists.  ending"
    exit 1
fi

if [ -e ~/$DIR ] ; then
    mv ~/$DIR ~/$DIR.old
fi

mkdir ~/$DIR
cp *.sh *.js *.css *.md *.html *.txt ~/$DIR
cp -r node_modules ~/$DIR
rm -f $ITEM/*~
cp -r $ITEM ~/$DIR
sed -i -e s!models/loan!$ITEM! ~/$DIR/contract_viewer.html
sed -i -e s!models/loan!$ITEM! ~/$DIR/calc-contract.js

cd ~
zip -r ~/$DIR $DIR
echo
pushd ~/$DIR/$ITEM > /dev/null
for i in *.js ; do
    echo `md5sum $i`
done
popd > /dev/null
rm -rf $DIR

