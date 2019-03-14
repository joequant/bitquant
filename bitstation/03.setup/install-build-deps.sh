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
#dnf upgrade --best --nodocs --allowerasing --refresh -y -x chkconfig -x filesystem
#export http_proxy=http://172.17.0.1:3128/
#export https_proxy=http://172.17.0.1:3128/
#export ftp_proxy=http://172.17.0.1:3128/
#export HTTP_PROXY=http://172.17.0.1:3128/
#export PIP_INDEX_URL=http://localhost:3141/root/pypi/+simple/
#export GIT_PROXY=http://localhost:8080/

dnf --setopt=install_weak_deps=False --best install -v -y \
    --nodocs --allowerasing --refresh \
      gcc-c++ \
      make \
      r-quantlib \
      pkgconfig\(libczmq\) \
      zeromq-devel \
      giflib-devel \
      cmake \
      python3-tornado \
      python3-mglob \
      python3-pytz \
      python3-devel \
      readline-devel \
      lapack-devel \
      python3-pandas \
      python3-numpy \
      python3-numpy-devel \
      python3-tables \
      python3-scipy \
      python3-qstk \
      python3-quantlib \
      python3-scikits-learn \
      python3-rpy2 \
      python3-xlwt \
      python3-xlrd \
      python3-gevent \
      python3-sqlalchemy \
      python3-sympy \
      python3-pillow \
      python3-lxml \
      python3-mistune \
      python3-cryptography \
      python3-pyasn1 \
      python3-pyglet \
      python3-py4j \
      python3-mysql \
      curl-devel \
      icu-devel \
      libpcre-devel \
      liblzma-devel \
      libbzip2-devel \
      zeromq-devel \
      ta-lib-devel \
      libxml2-devel \
      make \
      python3-cairo-devel \
      jpeg-devel \
      java-devel \
      openmpi-devel \
      libssh2-devel \
      ruby-devel \
      libtool \
      automake \
      autoconf \
      swig \
      protobuf-devel \
      unwind-devel

# ruby-sass for ethercalc
#zeromq-devel for R kernel
#libxml2-devel for RCurl
#unzip for R devtool builds
#cffi for caravel
#cairo for jupyterlab_bokeh.git or jpeg-devel
# llvm for numba
# openmpi-devel for horvod
# libssh2-devel for git2r ssh transport

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

#gcc-c++ is needed for ethercalc
#make is needed for ethercalc

# Compression libraries needed for Rpy

# sox to play sounds for algobroker
# pillow is for toyplot
# lxml for matta
# zeromq-utils are necessary for IRkernel
# pyasn1 for jupyter extensions
