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
ADMIN=webmin

#repeat packages in setup
$SUDO dnf --setopt=install_weak_deps=False --best install -v -y --nodocs \
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

$SUDO dnf --setopt=install_weak_deps=False --best install -v -y --nodocs \
nodejs \
npm \
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
      $PYTHON-mistune \
      $PYTHON-cffi \
      $PYTHON-cryptography \
      $PYTHON-pyasn1 \
      $PYTHON-cython \
      jupyter-client \
      jupyter-core \
      jupyter-console \
      jupyter-notebook \
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
      make \
      ruby-sass \
      $PYTHON-cairo-devel \
      jpeg-devel

# ruby-sass for ethercalc
#zeromq-devel for R kernel
#libxml2-devel for RCurl
#unzip for R devtool builds
#cffi for caravel
#cairo for jupyterlab_bokeh.git or jpeg-devel

#cmake is for building shiny-server
#tornado and mglob is for ipython
#readline-devel, python-devel, lapack-devel are for Rpy
# python-backports-ssl_match_hostname is a require of python-urllib3 which
#    is required by cloud-init

# For ipython we including 
# python-pandas
# python-tables
# python-scipy

# python-mistune is needed by jupyter-nbconvert but the autorequires
# seems broken

# curl-devel is needed for Rcurl
# icu-i18n-devel is needed for Rpy

#python-cythong is for Finance-Python
# don't start up server
$SUDO systemctl disable hsqldb

#gcc-c++ is needed for ethercalc
#make is needed for ethercalc

# Compression libraries needed for Rpy

# sox to play sounds for algobroker
# pillow is for toyplot
# lxml for matta

# pyasn1 for jupyter extensions
