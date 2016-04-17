#!/bin/bash
$SUDO docker rmi $($SUDO docker images | grep "^<none>" | awk '{print $3}')
