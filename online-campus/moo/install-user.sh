#!/bin/bash

cd /home/user
wget 'https://master.dl.sourceforge.net/project/ele/enCore%20Database/enCore%205.0b/enCore-5.0b.tar.gz'
wget 'http://lingo.uib.no/v5/downloads/LambdaMOO-1.8.1-unicode.tar.gz'
mkdir moo
cd moo
mkdir bin
mkdir src
cd ..
tar xzvf LambdaMOO-1.8.1-unicode.tar.gz
cd MOO-1.8.1
chmod a+x ./configure
./configure
make
cd ..
mv MOO-1.8.1/moo moo/bin
tar xzf enCore-5.0b.tar.gz
mv encore/enCore.db moo/bin
mv encore moo

