#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
# 
# Note that all apache modules should have already been installed
# in the bootstrap image.  Otherwise you will have the system attempt
# to reload httpd which causes the httpd connection to go down
#
# dokuwiki also needs to be in bootstrap for the same reasons

if grep -q Cauldron /etc/release  ; then 
JAVA=java-1.8.0-openjdk-devel
fi

if [[ $UID -ne 0 ]]; then
  SUDO=sudo
fi

OPTS=$(getopt -o "" --long with-mifos,with-opengamma,no-mifos,no-opengamma -- "$@")

eval set -- "$OPTS"

MIFOS_PKGS="tomcat mysql mysql-connector-java"
OPENGAMMA_PKGS="maven \
  maven-clean-plugin \
  maven-assembly-plugin \
  maven-compiler-plugin \
  maven-dependency-plugin \
  maven-install-plugin \
  maven-release-plugin \
  aether \
  aether-connector-basic \
  aether-transport-file \
  aether-transport-http \
  aether-transport-wagon"

MY_MIFOS_PKGS=$MIFOS_PKGS
MY_OPENGAMMA_PKGS=$OPENGAMMA_PKGS

while true; do
   case "$1" in
      --with-mifos )  MY_MIFOS_PKGS=$MIFOS_PKGS ; shift ;;
      --with-opengamma ) MY_OPENGAMMA_PKGS=$MY_OPENGAMMA_PKGS; shift ;;
      --no-mifos )  MY_MIFOS_PKGS="" ; shift ;;
      --no-opengamma ) MY_OPENGAMMA_PKGS=""; shift ;;
      -- ) shift ; break ;;
      * ) break ;;
   esac
done

set -e

#repeat packages in setup
$SUDO urpmi --no-recommends \
--auto \
--downloader "curl" \
--curl-options "--retry 5 --speed-time 30 --connect-timeout 30" \
apache \
apache-mod_suexec \
apache-mod_proxy \
apache-mod_php \
apache-mod_authnz_external \
apache-mod_ssl \
avahi \
dokuwiki \
python-flask \
python-pexpect

#other packages
$SUDO urpmi --no-recommends \
--auto \
--downloader "curl" \
--curl-options "--retry 5 --speed-time 30 --connect-timeout 30" \
$URPMI_OPTIONS \
$MY_MIFOS_PKGS \
$MY_OPENGAMMA_PKGS \
fop \
nodejs \
gcc-c++ \
ipython make postgresql9.3-devel \
krb5-appl-clients \
python-flask \
python-pexpect \
R-base \
vim-minimal \
rstudio-server \
fudge-devel \
log4cxx-devel \
postgresql9.3-server \
python-pyzmq \
dokuwiki \
cmake \
ipython \
python-tornado \
python-mglob \
dokuwiki-plugin-s5  \
python-matplotlib \
python-py4j \
python-pyro4 \
python-pytz \
python-pip \
python-devel \
readline-devel \
lapack-devel \
python-pandas \
python-zipline \
$JAVA \
python-backports-ssl_match_hostname \
python-tables \
python-scipy \
curl-devel \
ajenti \
dokuwiki-plugin-auth \
icu-devel \
python-sympy

#cmake is for building shiny-server
#tornado and mglob is for ipython
#readline-devel, python-devel, lapack-devel are for Rpy
# python-backports-ssl_match_hostname is a require of python-urllib3 which
#    is required by cloud-init

# For ipython we including 
# python-pandas
# python-tables
# python-scipy

# curl-devel is needed for Rcurl
# icu-i18n-devel is needed for Rpy

# don't start up server
$SUDO systemctl disable hsqldb

#gcc-c++ is needed for ethercalc







