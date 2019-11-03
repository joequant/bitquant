#!/bin/bash
set -e -v
echo "ZONE=UTC" > /etc/sysconfig/clock
export TZ="UTC"
useradd user
chmod a+rx ~user
echo 'cubswin:)' | passwd user --stdin
echo 'cubswin:)' | passwd root --stdin
cd ~user
mkdir git
cd git
git clone --single-branch --depth 1 https://github.com/joequant/bitquant.git
chown -R user:user .
cd ~user/git/bitquant/bitstation/web/scripts
./setup.sh bitstation
su user -p -c "/tmp/bootstrap.sh"
