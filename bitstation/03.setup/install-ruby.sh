#!/bin/bash
# TODO - fixes
set -v
gem install --no-ri --no-rdoc cztop ffi-rzmq -n /usr/bin -i /usr/share/gems

#disable Werror
CPPFLAGS="-Wno-error=deprecated-declarations" gem install --no-ri --no-rdoc rbczmq -n /usr/bin -i /usr/share/gems
gem install --no-ri --no-rdoc iruby -n /usr/bin -i /usr/share/gems
iruby register --force
mv /root/.ipython/kernels/ruby /usr/share/jupyter/kernels

