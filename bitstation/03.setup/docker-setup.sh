#!/bin/bash
set -e
echo "ZONE=UTC" > /etc/sysconfig/clock
export TZ="UTC"

source /tmp/install-build-deps.sh
useradd user
chmod a+rx ~user
echo 'cubswin:)' | passwd user --stdin
echo 'cubswin:)' | passwd root --stdin
cd ~user
mkdir git
cd git
git clone --single-branch --depth 1 https://github.com/joequant/bitquant.git
cd ~user/git/bitquant/bitstation/web/scripts
./setup_vimage.sh bitstation
su user - -c "~user/git/bitquant/bitstation/web/scripts/bootstrap.sh"
