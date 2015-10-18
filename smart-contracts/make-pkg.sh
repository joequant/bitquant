#!/bin/bash

ITEM=$1

mkdir ~/$ITEM
cp *.sh *.js *.css *.md *.html *.txt ~/$ITEM
cp -r node_modules ~/$ITEM
cp -r $ITEM ~/$ITEM
sed -i -e s!models/loan!$ITEM! ~/$ITEM/contract_analyzer.html
sed -i -e s!models/loan!$ITEM! ~/$ITEM/calc-contract.js

cd ~
zip -r ~/$ITEM $ITEM
echo "md5 hash" : `md5sum ~/$ITEM/$ITEM/TermSheet.js`
