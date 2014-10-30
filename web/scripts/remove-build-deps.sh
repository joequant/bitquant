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


$SUDO urpme \
--auto \
postgresql9.3-devel \
cmake \
gcc-c++


$SUDO urpme --auto-orphans --auto










