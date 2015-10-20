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
echo "version 5"
VERSION=5
fi

TESTING=false
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
if $TESTING ; then
urpmi.update --no-ignore "Core Updates" "Core Updates Testing"
fi
urpmi.update --no-ignore "Core Backports" "Core Backports Testing"
# Add backup server to make sure that we get fresh rpms
if [ "$VERSION" = "cauldron" ] ; then
urpmi.addmedia "Core backup" http://distro.ibiblio.org/mageia/distrib/$VERSION/`uname -m`/media/core/release --no-md5sum
urpmi.addmedia "Core updates backup" http://distro.ibiblio.org/mageia/distrib/$VERSION/`uname -m`/media/core/updates --no-md5sum
urpmi.addmedia "Bitquant sourceforge" https://sourceforge.net/projects/bitquant/files/rpms/`uname -m`/ --no-md5sum
if $TESTING ; then
urpmi.addmedia "Core updates testing backup" http://distro.ibiblio.org/mageia/distrib/$VERSION/`uname -m`/media/core/updates_testing
fi
urpmi.addmedia "Core backports backup" http://distro.ibiblio.org/mageia/distrib/$VERSION/`uname -m`/media/core/backports
urpmi.addmedia "Backports testing backup" http://ftp.sunet.se/pub/Linux/distributions/mageia/distrib/$VERSION/`uname -m`/media/core/backports_testing
fi

urpmi.update -a
#urpme --force --auto-orphans

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
