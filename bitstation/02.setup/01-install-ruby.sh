#!/bin/bash
# TODO - fixes
set -v
source $rootfsDir/tmp/proxy.sh
export CPPFLAGS="-Wno-error=deprecated-declarations"
export JUPYTER_DATA_DIR=/usr/share/jupyter

gem install --no-document ffi -n /usr/bin -i /usr/share/gems -- --with-ldflags="-pthread -ldl"
gem install --no-document ffi-rzmq -n /usr/bin -i /usr/share/gems

#disable Werror
gem install --no-document iruby -n /usr/bin -i /usr/share/gems --pre
gem install --no-document pry awesome_print gnuplot rubyvis nyaplot pry-doc -n /usr/bin -i /usr/share/gems
pump --shutdown
