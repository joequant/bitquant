#!/bin/bash
# TODO - fixes
set -v
export CPPFLAGS="-Wno-error=deprecated-declarations"
export JUPYTER_DATA_DIR=/usr/share/jupyter

gem install --no-ri --no-rdoc ffi-rzmq -n /usr/bin -i /usr/share/gems

#disable Werror
gem install --no-ri --no-rdoc iruby -n /usr/bin -i /usr/share/gems --pre
gem install --no-ri --no-rdoc pry awesome_print gnuplot rubyvis nyaplot pry-doc -n /usr/bin -i /usr/share/gems
iruby register --force
#mv /root/.ipython/kernels/ruby /usr/share/jupyter/kernels

# remember to link libzmq.so.5 to libzmq.so
