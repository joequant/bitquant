#!/bin/bash
# 
# Bash script to attach to a docker container using nsenter. 
# See the usage function for a list of options.
#
# Author: Juan Luis Baptiste <juan.baptiste@gmail.com>
# License: GNU GPL v2
#

DOCKER_BIN="docker"
NSENTER_BIN="nsenter"
#If you don't need sudo, comment this
SUDO_BIN="sudo"

use () {
cat << EOF
Use: $0 docker_container_id

Attach to a container using nsenter.

OPTIONS:

-h    Show this help message

EOF
}

docker_container_pid () {
    if [ "$1" != "" ];
    then
	echo "Getting container $1 PID ..."
        pid=$(sudo docker inspect --format {{.State.Pid}} $1)
	if [ $? -eq 0 ];
	then
	    docker_container_attach $pid
	else
	    echo -e "ERROR: Invalid container ID.\n"
	    exit 1
	fi
    fi  
}

docker_container_attach () {
    if [ "$1" != "" ];
    then
	echo "Attaching to container with PID $1 ..." 	    
        pid=$($SUDO_BIN $NSENTER_BIN --mount --uts --ipc --net --pid --target $1)
	if [ $pid -gt 0 ];
	then
	    echo "ERROR: Could not Attach to the container."
	    exit 1
	fi
    fi  
}

while getopts "h" OPTION
  do
    case $OPTION in
        h)
            use
            exit
            ;;
        ?)
            use
            exit
            ;;
    esac
 done           

 if [ "$1" != "" ]
 then
     docker_container_pid $1
     exit 0
 else
     echo -e "ERROR: No container to attach to.\n"
     exit 1
 fi    
