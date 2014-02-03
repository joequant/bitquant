#!/bin/bash
sudo ./img-zero.sh $1
VBoxManage modifyhd $1  --compact
zip $1
