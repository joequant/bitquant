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
URPMI_ROOT=http://distro.ibiblio.org/mageia/distrib
# Change everything to local user so that suexec will work
# ./setup.sh will take the owner of the scripts to set up the
# suexec environment, so this should be set correctly for 
# everything to work.

cd /home/$USER
chown -R $USER":"$USER git

echo "Resetting urpmi"
urpmi.removemedia -a
urpmi.addmedia --distrib --mirrorlist 'http://mirrors.mageia.org/api/mageia.'$VERSION'.'`uname -m`'.list'

urpmi.update --ignore "Core 32bit Release" "Core 32bit Updates"
urpmi.update --no-ignore "Nonfree Release" "Nonfree Updates"
urpmi.update --no-ignore "Tainted Release" "Tainted Updates" 
if $TESTING ; then
    urpmi.update --no-ignore "Core Updates" "Core Updates Testing"
    urpmi.update --no-ignore "Core Backports" "Core Backports Testing"
fi

# Add backup server to make sure that we get fresh rpms
if [ "$VERSION" = "cauldron" ] ; then
urpmi.addmedia "Core backup" $URPMI_ROOT/$VERSION/`uname -m`/media/core/release --no-md5sum
urpmi.addmedia "Core updates backup" $URPMI_ROOT/$VERSION/`uname -m`/media/core/updates --no-md5sum
urpmi.addmedia "Nonfree backup" $URPMI_ROOT/$VERSION/`uname -m`/media/nonfree/release --no-md5sum
urpmi.addmedia "Nonfree updates backup" $URPMI_ROOT/$VERSION/`uname -m`/media/nonfree/updates --no-md5sum
urpmi.addmedia "Tainted backup" $URPMI_ROOT/$VERSION/`uname -m`/media/tainted/release --no-md5sum
urpmi.addmedia "Tainted updates backup" $URPMI_ROOT/$VERSION/`uname -m`/media/tainted/updates --no-md5sum

if $TESTING ; then
urpmi.addmedia "Core updates testing backup" $URPMI_ROOT/$VERSION/`uname -m`/media/core/updates_testing
fi
urpmi.addmedia "Core backports backup" $URPMI_ROOT/$VERSION/`uname -m`/media/core/backports
urpmi.addmedia "Backports testing backup" $URPMI_ROOT/$VERSION/`uname -m`/media/core/backports_testing
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
