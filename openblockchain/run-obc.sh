#!/bin/bash
. env.sh
pushd obc-dev-env > /dev/null
vagrant ssh -c /openchain/build-scripts/run-obc.sh
popd > /dev/null
