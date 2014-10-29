#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $SCRIPT_DIR/rootcheck.sh

mkdir -p /var/run/opengamma
chmod a+rwx /var/run/opengamma

mkdir -p /var/log/OG-RStats
chmod a+rwx /var/log/OG-RStats
