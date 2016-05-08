#!/bin/bash
set -v
set -e
ITEM=$1
DATE=$(date +'%Y%m%d')
ZIPDIR=$(basename $ITEM)-$DATE
ITEMDIR=$(dirname $ITEM)

if [ -e ~/$ZIPDIR.zip ] ; then
    echo "package ~/$ZIPDIR.zip already exists.  ending"
    exit 1
fi

if [ -e ~/$ZIPDIR ] ; then
    mv ~/$ZIPDIR ~/$ZIPDIR.old
fi

mkdir ~/$ZIPDIR
cp *.sh *.js *.css *.md *.html ~/$ZIPDIR 
cp -r node_modules ~/$ZIPDIR
rm -f $ITEM/*~
mkdir -p ~/$ZIPDIR/$ITEMDIR
cp -r $ITEM ~/$ZIPDIR/$ITEMDIR
sed -i -e s!models/loan!$ITEM! ~/$ZIPDIR/contract_viewer.html
sed -i -e s!models/loan!$ITEM! ~/$ZIPDIR/calc-contract.js

cd ~
zip -r ~/$ZIPDIR $ZIPDIR
echo
pushd ~/$ZIPDIR/$ITEM > /dev/null
for i in *.js ; do
    echo `md5sum $i`
done
popd > /dev/null
rm -rf $ZIPDIR

