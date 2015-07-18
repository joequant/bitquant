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

ADMIN=ajenti
PYTHON=python3
IPYTHON=python3-ipython
PYTHON_COMPAT=

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
$PYTHON-flask \
$PYTHON-pexpect

#other packages
# no-verify-rpm is required for quantlib

$SUDO urpmi \
--auto \
--downloader "curl" \
--curl-options "--retry 5 --speed-time 30 --connect-timeout 30" \
$URPMI_OPTIONS \
$IPYTHON 

$SUDO urpmi --no-recommends \
--auto \
--no-verify-rpm \
--downloader "curl" \
--curl-options "--retry 5 --speed-time 30 --connect-timeout 30" \
$URPMI_OPTIONS \
nodejs \
gcc-c++ \
make \
krb5-appl-clients \
$PYTHON-flask \
$PYTHON-pexpect \
R-base \
r-quantlib \
vim-minimal \
$PYTHON-pyzmq \
dokuwiki \
cmake \
$PYTHON-tornado \
$PYTHON-mglob \
dokuwiki-plugin-s5  \
$PYTHON-matplotlib \
$PYTHON-pytz \
$PYTHON-pip \
$PYTHON-devel \
readline-devel \
lapack-devel \
$PYTHON-pandas \
$PYTHON-zipline \
$PYTHON_COMPAT \
$PYTHON-tables \
$PYTHON-scipy \
$PYTHON-qstk \
$PYTHON-statsmodels \
$PYTHON-quantlib \
$PYTHON-scikits-learn \
$PYTHON-patsy \
$PYTHON-pyalgotrade \
$PYTHON-quandl \
$PYTHON-rpy2 \
curl-devel \
$ADMIN \
dokuwiki-plugin-auth \
icu-devel \
$PYTHON-sympy \
libpcre-devel \
liblzma-devel \
libbzip2-devel \
zeromq-devel \
libxml2-devel \
unzip

if [ ! -e /usr/bin/ipython ] ; then
pushd /usr/bin
ln -s ipython3 ipython
popd
fi

#zeromq-devel for R kernel
#libxml2-devel for RCurl
#unzip for R devtool builds

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





