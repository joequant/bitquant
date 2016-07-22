#!/bin/bash
echo "ZONE=Asia/Hong_Kong" > /etc/sysconfig/clock
export TZ="Asia/Hong_Kong"
urpmi.removemedia -a
urpmi.addmedia --distrib \
	       --mirrorlist \
	       'http://mirrors.mageia.org/api/mageia.cauldron.x86_64.list'
urpmi.addmedia --no-md5sum \
	       "Core backup" http://distro.ibiblio.org/mageia/distrib/cauldron/x86_64/media/core/release
urpmi.addmedia --no-md5sum \
	       "Core updates backup" http://distro.ibiblio.org/mageia/distrib/cauldron/x86_64/media/core/updates
urpmi --no-recommends --auto --excludedocs urpmi
urpmi --replacepkgs --excludedocs locales glibc
urpmi --auto-select --auto --no-recommends --no-md5sum --excludedocs
urpmi --no-recommends --no-md5sum --excludedocs --auto git
useradd user
echo 'cubswin:)' | passwd user --stdin
echo 'cubswin:)' | passwd root --stdin
cd ~user
mkdir git
cd git
git clone --single-branch --depth 1 https://github.com/joequant/bitquant.git
mkdir -p /etc/sysusers.d
cp ~user/git/bitquant/bitstation/system.conf /etc/sysusers.d
systemd-sysusers
urpmi --no-recommends --no-md5sum --excludedocs \
    --auto sudo apache apache-mod_suexec \
    apache-mod_proxy \
    apache-mod_php apache-mod_authnz_external \
    apache-mod_ssl dokuwiki python3-flask python3-pexpect

cd ~user/git/bitquant/web/scripts
./setup_vimage.sh bitstation
rm -f /lib/systemd/system/multi-user.target.wants/*
rm -f /etc/systemd/system/*.wants/*
rm -f /lib/systemd/system/local-fs.target.wants/*
rm -f /lib/systemd/system/sockets.target.wants/*udev*
rm -f /lib/systemd/system/sockets.target.wants/*initctl*
rm -f /lib/systemd/system/basic.target.wants/*
rm -f /lib/systemd/system/anaconda.target.wants/*
rm -f /lib/systemd/system/*resolve1*
rm -f /lib/systemd/system/*resolved*
rm -f /lib/systemd/system/*udev*
rm -f /lib/systemd/system/*journal*
rm -f /lib/systemd/system/*networkd*
rm -rf /etc/resolveconf /sbin/resolvconf /etc/rc.d/init.d/resolvconf

URPMI_OPTIONS="--excludedocs --no-md5sum --no-verify-rpm" /usr/share/bitquant/install-build-deps.sh 
sudo -u user ~user/git/bitquant/web/scripts/bootstrap.sh
sudo -u user touch ~user/git/bitquant/web/log/bootstrap.done
~user/git/bitquant/web/scripts/remove-build-deps.sh
rm -rf /usr/lib64/python*/test
rm -rf /usr/lib64/python*/site-packages/pandas/tests
rm -rf /usr/lib64/python*/site-packages/pandas/io/tests
rm -rf /usr/lib64/python*/site-packages/pandas/tseries/tests
rm -rf /usr/lib64/python*/site-packages/matplotlib/tests
rm -rf /usr/lib64/python*/site-packages/mpl_toolkits/tests
rm -rf /usr/lib/python*/site-packages/flask/testsuite
rm -rf /usr/lib/python*/site-packages/jinja2/testsuite
rm -rf /usr/lib/python*/site-packages/ggplot/tests
rm -rf /usr/lib/python*/site-packages/sympy/*/tests
rm -rf /usr/share/doc
rm -rf /home/user/git/shiny-server 

