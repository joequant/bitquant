#!/bin/bash
# check if root
# exit if not

if [[ $UID -eq 0 ]]; then
  echo "$0 must not be run as root"
  exit 1
fi
