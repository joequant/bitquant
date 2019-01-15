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

if [[ $UID -ne 0 ]]; then
  SUDO=sudo
fi

# Refresh locale and glibc for missing latin items
# needed for R to build packages
dnf shell -v -y --setopt=install_weak_deps=False <<EOF
reinstall --best --nodocs --allowerasing locales locales-en glibc
run
EOF

#repeat packages in setup
$SUDO dnf --setopt=install_weak_deps=False --best install -v -y --nodocs \
      apache \
      apache-mod_suexec \
      apache-mod_proxy \
      apache-mod_php \
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
      python3-pexpect

$SUDO chmod a+x /usr/lib64/R/bin/*

