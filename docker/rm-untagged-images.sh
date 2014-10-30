#!/bin/bash
sudo docker rmi $(sudo docker images | grep "^<none>" | awk '{print $3}')
