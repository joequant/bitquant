#!/bin/bash
# TODO - fixes
set -v
export CPPFLAGS="-Wno-error=deprecated-declarations"
export JUPYTER_DATA_DIR=/usr/share/jupyter

gem install --no-document ffi -n /usr/bin -i /usr/share/gems -- --with-ldflags="-pthread -ldl"
gem install --no-document ffi-rzmq -n /usr/bin -i /usr/share/gems

#disable Werror
gem install --no-document iruby -n /usr/bin -i /usr/share/gems --pre
gem install --no-document pry awesome_print gnuplot rubyvis nyaplot pry-doc -n /usr/bin -i /usr/share/gems
iruby register --force
#mv /root/.ipython/kernels/ruby /usr/share/jupyter/kernels

# remember to link libzmq.so.5 to libzmq.so
