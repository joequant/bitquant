#!/bin/bash
# TODO - fixes
set -v
gem install --no-ri --no-rdoc cztop ffi-rzmq

#disable Werror
CPPFLAGS="-Wno-error=deprecated-declarations" gem install --no-ri --no-rdoc rbczmq
gem install --no-ri --no-rdoc iruby --pre
iruby register --force
mv /root/.ipython/kernels/ruby /usr/share/jupyter/kernels
mv /usr/local/bin/* /usr/bin
