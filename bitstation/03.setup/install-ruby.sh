#!/bin/bash
set -v
gem install --no-ri --no-rdoc cztop ffi-rzmq

#disable Werror
CPPFLAGS="-Wno-error=deprecated-declarations" gem install --no-ro --no-rdoc rbczmq
gem install --no-ri --no-rdoc iruby --pre
iruby register --force

