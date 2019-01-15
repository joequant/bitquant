#!/bin/bash

mkdir ~/sourceforge
sshfs drjoe@frs.sourceforge.net:/home/frs/project/bitquant ~/sourceforge
cd ~/sourceforge
mkdir -p srpms

