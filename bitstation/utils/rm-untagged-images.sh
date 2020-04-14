#!/bin/bash
CMD=${1:-docker}
$CMD rmi $($CMD images | grep "^<none>" | awk '{print $3}')
