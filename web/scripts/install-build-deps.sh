#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
# 
# Note that all apache modules should have already been installed
# in the bootstrap image.  Otherwise you will have the system attempt
# to reload httpd which causes the httpd connection to go down
#
# dokuwiki also needs to be in bootstrap for the same reasons
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPT_DIR/environment.sh

if grep -q Cauldron /etc/release  ; then 
JAVA=java-1.8.0-openjdk-devel
fi

if [[ $UID -ne 0 ]]; then
  SUDO=sudo
fi

OPTS=$(getopt -o "" --long with-mifos,with-opengamma,no-mifos,no-opengamma -- "$@")

eval set -- "$OPTS"

MIFOS_PKGS="tomcat mysql mysql-connector-java unzip $JAVA"
OPENGAMMA_PKGS="maven \
  maven-clean-plugin \
  maven-assembly-plugin \
  maven-compiler-plugin \
  maven-dependency-plugin \
  maven-install-plugin \
  aether \
  aether-connector-basic \
  aether-transport-file \
  aether-transport-http \
  aether-transport-wagon \
  python-py4j \
  fop \
  postgresql9.3-devel \
  fudge-devel \
  $JAVA"

while true; do
   case "$1" in
      --with-mifos )  INSTALL_MIFOS=true ; shift ;;
      --with-opengamma ) INSTALL_OPENGAMMA=true ; shift ;;
      --no-mifos )  INSTALL_MIFOS=false ; shift ;;
      --no-opengamma ) INSTALL_OPENGAMMA=false ; shift ;;
      -- ) shift ; break ;;
      * ) break ;;
   esac
done

if [[ "$INSTALL_MIFOS" == "true" ]] ; then
MY_MIFOS_PKGS=$MIFOS_PKGS
else
MY_MIFOS_PKGS=""
fi

if [[ "$INSTALL_OPENGAMMA" == "true" ]] ; then
MY_OPENGAMMA_PKGS=$OPENGAMMA_PKGS
else
MY_OPENGAMMA_PKGS=""
fi

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
nodejs \
gcc-c++ \
ipython make \
krb5-appl-clients \
python-flask \
python-pexpect \
R-base \
r-quantlib \
vim-minimal \
rstudio-server \
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
python-pyro4 \
python-pytz \
python-pip \
python-devel \
readline-devel \
lapack-devel \
python-pandas \
python-zipline \
python-backports-ssl_match_hostname \
python-tables \
python-scipy \
python-qstk \
python-statsmodels \
python-quantlib \
python-scikits-learn \
python-pyalgotrade \
curl-devel \
ajenti \
dokuwiki-plugin-auth \
icu-devel \
python-sympy \
libpcre-devel \
liblzma-devel \
libbzip2-devel 

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

# Compression libraries needed for Rpy





