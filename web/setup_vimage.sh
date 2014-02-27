#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
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

urpmi.removemedia -a
urpmi.addmedia --distrib --mirrorlist 'http://mirrors.mageia.org/api/mageia.'$VERSION'.x86_64.list'
urpmi.update -a
urpme --force --auto-orphans

pushd $SCRIPT_DIR > /dev/null
. rootcheck.sh
. configcheck.sh
./setup.sh $config
mkdir -p /etc/ssh 
mkdir -p /etc/cloud
cp sshd_config /etc/ssh
cp cloud.cfg /etc/cloud
cp sudoers /etc

# workaround bad mandriva-everytime.service
# fix Mageia bug 12868
# https://bugs.mageia.org/show_bug.cgi?id=12868

cp  mandriva-everytime.service  /usr/lib/systemd/system
popd
rm -rf /etc/udev/rules.d/70-persistent-net.rules
touch /etc/udev/rules.d/70-persistent-net.rules
cat <<EOP >> /etc/rc.d/init.d/mandrake_everytime
echo 'login as user user password cubswin:)' >> /etc/issue
EOP
cat <<EOP >> /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT='console=ttyS0 nosplash'
EOP
update-grub2
echo $config > /etc/hostname
