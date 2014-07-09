#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
# 
# Note that all apache modules should have already been installed
# in the bootstrap image.  Otherwise you will have the system attempt
# to reload httpd which causes the httpd connection to go down
#
# dokuwiki also needs to be in bootstrap for the same reasons

set -e
sudo urpmi --no-suggests \
--auto \
--downloader "curl" \
--curl-options "--retry 5 --speed-time 30 --connect-timeout 30" \
maven \
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
aether-transport-wagon \
fop \
nodejs \
gcc-c++ \
ipython make postgresql9.3-devel \
strace \
screen \
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
python-devel

#cmake is for building shiny-server
#tornado and mglob is for ipython

# don't start up server
sudo systemctl disable hsqldb

#gcc-c++ is needed for ethercalc







