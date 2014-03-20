#!/bin/bash
# Setup and configure website to use giving configuration

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ME=`stat -c "%U" $SCRIPT_DIR/setup.sh`
GROUP=`stat -c "%G" $SCRIPT_DIR/setup.sh`

pushd $SCRIPT_DIR > /dev/null
. rootcheck.sh
. configcheck.sh

pushd /var/www/html > /dev/null
rm -f *
for i in $SCRIPT_DIR/$config/*; do 
ln -s -f  ../../..$SCRIPT_DIR/$config/$(basename $i) $(basename $i)
done
popd > /dev/null

# Do a special copy so that suexec works
pushd /var/www/cgi-bin > /dev/null
rm -rf /var/www/cgi-bin/*
for i in $SCRIPT_DIR/cgi-bin/*; do
cp -r ../../..$SCRIPT_DIR/cgi-bin/$(basename $i) $(basename $i)
chown -R $ME:$GROUP $(basename $i)
done
popd > /dev/null

pushd /etc/httpd/conf/webapps.d > /dev/null
if [ -f 00_default_vhosts.conf ] ; then
mv -f 00_default_vhosts.conf 00_default_vhosts.conf.bak
fi
popd > /dev/null

for i in `find files/* -type d` ; do mkdir -p ${i#files} ;done
for i in `find files/* -type f ! -iname "*~" ` 
do echo "copying to ${i#files}"
cp $i ${i#files} 
sed -i -e "s/%USER%/$ME/g" -e "s/%GROUP%/$GROUP/g" ${i#files} 
done

systemctl daemon-reload
systemctl start bitquant
systemctl enable bitquant


