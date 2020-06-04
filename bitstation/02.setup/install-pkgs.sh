#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
# 
# Note that all apache modules should have already been installed
# in the bootstrap image.  Otherwise you will have the system attempt
# to reload httpd which causes the httpd connection to go down
#
# dokuwiki also needs to be in bootstrap for the same reasons
set -e -v

cat <<EOF >> $rootfsDir/etc/dnf/dnf.conf
fastestmirror=true
max_parallel_downloads=15
EOF

source $rootfsDir/tmp/proxy.sh
dnf makecache $rootfsArg
dnf upgrade --best --nodocs --allowerasing --refresh -y \
    --setopt=install_weak_deps=False $rootfsArg

# workaround bug RHEL #1765718
dnf autoremove python3-dnf-plugins-core -y $rootfsArg

# Refresh locale and glibc for missing latin items
# needed for R to build packages
dnf reinstall -v -y --setopt=install_weak_deps=False --best --nodocs --allowerasing \
    locales locales-en glibc $rootfsArg

#repeat packages in setup
dnf --setopt=install_weak_deps=False --best --allowerasing install -v -y --nodocs $rootfsArg \
      apache \
      apache-mod_proxy \
      php-fpm \
      apache-mod_authnz_external \
      apache-mod_ssl \
      dokuwiki \
      dokuwiki-plugin-auth \
      dokuwiki-plugin-dokufreaks \
      dokuwiki-plugin-s5  \
      python3-flask \
      python3-pexpect \
      python3-matplotlib \
      webmin \
      sudo \
      git \
      R-base \
      nodejs \
      npm \
      octave \
      redis \
      unzip \
      mongodb-server \
      mongodb \
      mongo-tools \
      bitcoind \
      java \
      texlive \
      vim-minimal \
      ruby-sass \
      zeromq-utils \
      python3-pip \
      python3-cffi \
      python3-cython \
      python3-pexpect \
      R-Rcpp-devel \
      root \
      python3-jupyroot \
      root-r \
      libglu-devel

chmod a+x $rootfsDir/usr/lib64/R/bin/*
dnf clean all $rootfsArg
rm -rf $rootfsDir/var/log/*.log
rm -rf $rootfsDir/usr/share/gems/doc/*
rm -rf $rootfsDir/usr/lib/python3.5
rm -rf $rootfsDir/usr/lib64/python3.5

pushd $rootfsDir/etc/httpd/conf
rm -f conf.d/security.conf
cp $rootfsDir/tmp/00_mpm.conf modules.d
if [ -e modules.d/00-php-fpm.conf ] ; then
    mv modules.d/00-php-fpm.conf modules.d/10-php-fpm.conf
fi
popd
