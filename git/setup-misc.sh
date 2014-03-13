#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MY_NAME=joequant
declare -A upstream
repos="JyNI XChange JSurface3D zipline etherpad-lite ethercalc"
upstream[JyNI]="https://github.com/Stewori/JyNI"
upstream[XChange]="https://github.com/timmolter/XChange"
upstream[JSurface3D]="https://github.com/OpenGamma/JSurface3D"
upstream[zipline]="https://github.com/quantopian/zipline"
upstream[trade-manager]="https://code.google.com/p/trade-manager"
upstream[etherpad-lite]="https://github.com/ether/etherpad-lite"
upstream[ethercalc]="https://github.com/audreyt/ethercalc"

cd $SCRIPT_DIR
pushd ../..

if [ ! -d Fudge-Python ]
then
git clone https://github.com/$MY_NAME/Fudge-Python
pushd Fudge-Python
git fetch origin
popd
else
echo "Repo $repo already present"
fi

for repo in $repos
do
if [ ! -d $repo ] 
then
git clone --progress https://github.com/$MY_NAME/$repo
pushd $repo
git remote add upstream ${upstream[$repo]}
git fetch upstream
git fetch origin
popd
else
echo "Repo $repo already present"
fi
done
popd


