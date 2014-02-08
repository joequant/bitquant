#!/bin/bash -v
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
urpmi.removemedia -a
urpmi.addmedia --distrib --mirrorlist 'http://mirrors.mageia.org/api/mageia.4.x86_64.list'
urpmi.update -a
urpme --force --auto-orphans

pushd $SCRIPT_DIR
./setup.sh
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
cd ~user
chown -R user:user git


