#!/bin/bash
# check if root
# exit if not

if [[ $UID -ne 0 ]]; then
  echo "$0 must be run as root"
  exit 1
fi
