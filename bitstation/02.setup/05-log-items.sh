#!/bin/bash
pushd /usr/share/bitquant
rpm -qa | sort > rpm.log
pip list > pip.log
jupyter serverextension list > jupyter-serverextension.log
jupyter labextension list > jupyter-labextension.log
jupyter nbextension list > jupyter-nbextension.log
jupyter bundlerextension list > jupyter-bundlerextension.log
popd
chmod a+r /usr/share/bitquant/*
