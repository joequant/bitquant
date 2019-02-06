#!/bin/bash
set -v
gem install cztop ffi-rzmq

#disable Werror
CPPFLAGS="-Wno-error=deprecated-declarations" gem install rbczmq
gem install iruby --pre
iruby register --force

