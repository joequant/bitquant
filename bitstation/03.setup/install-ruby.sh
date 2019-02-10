#!/bin/bash
# TODO - fixes
set -v
export CPPFLAGS="-Wno-error=deprecated-declarations"
export LDFLAGS=""
export ldflags=""
gem install --no-ri --no-rdoc cztop ffi-rzmq -n /usr/bin -i /usr/share/gems

#disable Werror
gem install --no-ri --no-rdoc iruby -n /usr/bin -i /usr/share/gems
iruby register --force
mv /root/.ipython/kernels/ruby /usr/share/jupyter/kernels

