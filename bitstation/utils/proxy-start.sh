#!/bin/bash
mkdir -p log
devpi-server >> log/devpi-server.log 2>&1 &
git-cache-http-server $GIT_CACHE_ARGS >> log/git-cache-http-server.log 2>&1 &
verdaccio >> log/verdaccio.log 2>&1 &
