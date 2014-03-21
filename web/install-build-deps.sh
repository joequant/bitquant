#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run
#
# The limit on the speed is to prevent stalls due to bufferbloat


sudo urpmi --no-suggests \
--auto \
--limit-rate 500000 \
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
vim-minimal

# don't start up server
sudo systemctl disable hsqldb

#gcc-c++ is needed for ethercalc







