#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPT_DIR/environment.sh

if [ $# -ge 1 ] ; then
export PATH_INFO=$1
else
echo "Content-type: text/html"
echo ""
fi

if [ "$PATH_INFO" = "" ] ; then
echo "no path"
exit 0
fi

export CONFIG=${PATH_INFO#/}

echo "<pre>"
pushd $WEB_DIR > /dev/null
if [ -e "config/$CONFIG" ] ; then
for i in `find config/$CONFIG/* -type d` ; do sudo mkdir -p ${i#files} ;done
for i in `find config/$CONFIG/* -type f ! -iname "*~" ` 
do TARGET=${i#config/$CONFIG}
echo "copying to $TARGET"
sudo cp $i $TARGET
sudo sed -i -e "s/%USER%/$ME/g" -e "s/%GROUP%/$GROUP/g" $TARGET
if [ -e "config/user/$CONFIG" ] ; then
OWNER=`cat config/user/$CONFIG | sed -e "s/%USER%/$ME/g" -e "s/%GROUP%/$GROUP/g"`
echo "changing owner of $TARGET to $OWNER"
sudo chown  $OWNER $TARGET
fi

done
popd > /dev/null
else
echo "Unknown config $CONFIG"
fi
echo "</pre>"
