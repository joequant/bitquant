#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_DIR=$SCRIPT_DIR/..
echo "Running setup_vimage.sh"
#VERSION=cauldron
#USER=joe
if grep -q Cauldron /etc/release  ; then 
echo "cauldron" 
VERSION=cauldron
else
echo "version 6"
VERSION=6
fi

TESTING=false
USER=user

# Change everything to local user so that suexec will work
# ./setup.sh will take the owner of the scripts to set up the
# suexec environment, so this should be set correctly for 
# everything to work.

cd /home/$USER
chown -R $USER":"$USER git

dnf --setopt=install_weak_deps=False --best -v -y --nodocs upgrade 

echo "Copy configuration files"
pushd $SCRIPT_DIR > /dev/null
. rootcheck.sh
. configcheck.sh

# bootstrap sudo
./setup.sh $config
$WEB_DIR/cgi-bin/bittrader/conf.sh /vimage
popd

rm -rf /etc/udev/rules.d/70-persistent-net.rules
touch /etc/udev/rules.d/70-persistent-net.rules

cat <<EOF >> /home/$USER/.bash_profile
. $SCRIPT_DIR/login-message.sh
EOF

echo $config > /etc/hostname
