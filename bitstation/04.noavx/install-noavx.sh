#!/bin/bash
set -v
set +o errexit
pip3 uninstall tensorflow -y
pip3 install --upgrade http://github.com/evdcush/TensorFlow-wheels/releases/download/tf-1.13.1-py37-cpu-westmere/tensorflow-1.13.1-cp37-cp37m-linux_x86_64.whl --prefix /usr
