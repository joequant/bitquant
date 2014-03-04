#!/bin/bash
# These are all of the packages that need to be installed before bootstrap
# is run

sudo urpmi --no-suggests --auto \
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
2>&1

#gcc-c++ is needed for ethercalc







