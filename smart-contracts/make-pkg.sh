#!/bin/bash

ITEM=$1

if [ -e ~/$ITEM.zip ] ; then
    echo "package already exists.  ending"
    exit 1
fi

if [ -e ~/$ITEM ] ; then
    mv ~/$ITEM ~/$ITEM.old
fi

mkdir ~/$ITEM
cp *.sh *.js *.css *.md *.html *.txt ~/$ITEM
cp -r node_modules ~/$ITEM
rm -f $ITEM/*~
cp -r $ITEM ~/$ITEM
sed -i -e s!models/loan!$ITEM! ~/$ITEM/contract_viewer.html
sed -i -e s!models/loan!$ITEM! ~/$ITEM/calc-contract.js

cd ~
zip -r ~/$ITEM $ITEM
echo "md5 hash" : `md5sum ~/$ITEM/$ITEM/TermSheet.js`
