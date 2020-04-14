#!/bin/bash
CMD=${1:-docker}
$CMD rm $($CMD ps -a -q) 
