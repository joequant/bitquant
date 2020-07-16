#!/bin/bash
parallel --tagstring '{}' --linebuffer source '/tmp/{}' :::  install-r-pkgs.sh install-python.sh
source /tmp/docker-setup.sh
parallel --tagstring '{}' --linebuffer source '/tmp/{}' :::  install-npm.sh install-ruby.sh install-r-pkgs-sudo.sh
source /tmp/remove-build-deps.sh
