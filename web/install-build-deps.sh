#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run

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
apache-mod_suexec \
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
postgresql9.3-server

# don't start up server
sudo systemctl disable hsqldb

#gcc-c++ is needed for ethercalc







