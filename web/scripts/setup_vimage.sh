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
echo "version 4"
VERSION=4
fi


USER=user
# Change everything to local user so that suexec will work
# ./setup.sh will take the owner of the scripts to set up the
# suexec environment, so this should be set correctly for 
# everything to work.

cd /home/$USER
chown -R $USER":"$USER git

echo "Resetting urpmi"
urpmi.removemedia -a
urpmi.addmedia --distrib --mirrorlist 'http://mirrors.mageia.org/api/mageia.'$VERSION'.'`uname -m`'.list'
urpmi.update --no-ignore "Core Updates"
urpmi.update --no-ignore "Core Backports" "Core Backports Testing"
# Add backup server to make sure that we get fresh rpms
urpmi.addmedia "Backports testing backup" http://ftp.sunet.se/pub/Linux/distributions/mageia/distrib/$VERSION/`uname -m`/media/core/backports_testing

urpmi.update -a
#urpme --force --auto-orphans

echo "Copy configuration files"
pushd $SCRIPT_DIR > /dev/null
. rootcheck.sh
. configcheck.sh
./setup.sh $config
pushd $WEB_DIR > /dev/null
for i in `find vimage/* -type d` ; do mkdir -p ${i#vimage} ;done
for i in `find vimage/* -type f` ; do cp $i ${i#vimage} ;done
popd
popd

# Turn off sshd by default
systemctl disable sshd.service
rm -rf /etc/udev/rules.d/70-persistent-net.rules
touch /etc/udev/rules.d/70-persistent-net.rules

cat <<EOF >> /home/$USER/.bash_profile
. $SCRIPT_DIR/login-message.sh
EOF

echo $config > /etc/hostname
