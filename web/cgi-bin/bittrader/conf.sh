#!/bin/bash
# set setuid so that it is run with the user which checked out the
# orginal git

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPT_DIR/environment.sh




if [[ $UID -ne 0 ]]; then
  SUDO=sudo
fi

if [ $# -ge 1 ] ; then
export PATH_INFO=$1
else
echo "Content-type: text/html"
echo ""
fi

if [[ $ME == "root" ]] ; then
echo "Owner of conf.sh should not be root"
exit 1
fi

if [ "$PATH_INFO" = "" ] ; then
echo "no path"
exit 0
fi

export CONFIG=${PATH_INFO#/}

echo "<pre>"
pushd $WEB_DIR > /dev/null
if [ -e "config/$CONFIG" ] ; then
for i in `find config/$CONFIG/* -type d` ; do $SUDO mkdir -p ${i#config/$CONFIG} ;done
for i in `find config/$CONFIG/* -type f ! -iname "*~" ` 
do TARGET=${i#config/$CONFIG}
echo "copying to $TARGET"
$SUDO cp $i $TARGET
$SUDO sed -i -e "s/%USER%/$ME/g" -e "s/%GROUP%/$GROUP/g" $TARGET
if [ -e "config/user/$CONFIG" ] ; then
OWNER=`cat config/user/$CONFIG | sed -e "s/%USER%/$ME/g" -e "s/%GROUP%/$GROUP/g"`
echo "changing owner of $TARGET to $OWNER"
$SUDO chown  $OWNER $TARGET
fi

done
if [ -e "config/exec/$CONFIG" ] ; then
echo "executing config/exec/$CONFIG"
. config/exec/$CONFIG
fi
popd > /dev/null
else
echo "Unknown config $CONFIG"
fi
echo "</pre>"
