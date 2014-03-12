#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Running setup_vimage.sh"
#VERSION=cauldron
#USER=joe
VERSION=4
USER=user
# Change everything to local user so that suexec will work
# ./setup.sh will take the owner of the scripts to set up the
# suexec environment, so this should be set correctly for 
# everything to work.

cd /home/$USER
chown -R $USER":"$USER git

echo "Resetting urpmi"
urpmi.removemedia -a
urpmi.addmedia --distrib --mirrorlist 'http://mirrors.mageia.org/api/mageia.'$VERSION'.x86_64.list'
urpmi.update -a
urpme --force --auto-orphans

echo "Copy configuration files"
pushd $SCRIPT_DIR > /dev/null
. rootcheck.sh
. configcheck.sh
./setup.sh $config
for i in `find vimage/* -type d` ; do mkdir -p ${i#files} ;done
for i in `find vimage/* -type f` ; do cp $i ${i#files} ;done
popd

rm -rf /etc/udev/rules.d/70-persistent-net.rules
touch /etc/udev/rules.d/70-persistent-net.rules
cat <<EOP >> /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT='nosplash'
EOP
update-grub2
echo $config > /etc/hostname
