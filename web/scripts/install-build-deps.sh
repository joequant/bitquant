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

PYTHON=python3
IPYTHON=python3-ipython
PYTHON_COMPAT=
#ADMIN=ajenti

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
dokuwiki \
$PYTHON-flask \
$PYTHON-pexpect \
$PYTHON-matplotlib \
$PYTHON-matplotlib-tk \
$ADMIN

$SUDO urpmi --no-recommends \
--auto \
--no-verify-rpm \
--downloader "curl" \
--curl-options "--retry 5 --speed-time 30 --connect-timeout 30" \
$URPMI_OPTIONS \
nodejs \
gcc-c++ \
make \
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
$PYTHON-pytz \
$PYTHON-pip \
$PYTHON-devel \
readline-devel \
lapack-devel \
$PYTHON-pandas \
$PYTHON-numpy \
$PYTHON-numpy-devel \
$PYTHON_COMPAT \
$PYTHON-tables \
$PYTHON-scipy \
$PYTHON-qstk \
$PYTHON-quantlib \
$PYTHON-scikits-learn \
$PYTHON-rpy2 \
$PYTHON-xlwt \
$PYTHON-xlrd \
      $PYTHON-gevent \
      $PYTHON-sqlalchemy \
      $PYTHON-sympy \
      $PYTHON-pillow \
      $PYTHON-lxml \
      $PYTHON-jupyter-notebook \
      $PYTHON-ipywidgets \
curl-devel \
dokuwiki-plugin-auth \
dokuwiki-plugin-dokufreaks \
icu-devel \
libpcre-devel \
liblzma-devel \
libbzip2-devel \
zeromq-devel \
ta-lib-devel \
libxml2-devel \
unzip \
mongodb-server \
mongodb \
mongo-tools \
      redis \
      make

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
#make is needed for ethercalc

# Compression libraries needed for Rpy

# sox to play sounds for algobroker
# pillow is for toyplot
# lxml for matta
