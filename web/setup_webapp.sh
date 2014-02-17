#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#VERSION=cauldron
#USER=joe
VERSION=4
USER=user

urpmi.removemedia -a
urpmi.addmedia --distrib --mirrorlist 'http://mirrors.mageia.org/api/mageia.'$VERSION'.x86_64.list'
urpmi.update -a
urpme --force --auto-orphans

pushd $SCRIPT_DIR
../rpm/install-build-deps.sh
../rpm/install-web-deps.sh
./setup.sh
mkdir -p /etc/ssh 
mkdir -p /etc/cloud
cp sshd_config /etc/ssh
cp cloud.cfg /etc/cloud
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
cd /home/$USER
chown -R $USER":"$USER git


