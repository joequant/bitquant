Requirements
------------

The docker script requires docker 1.8 to implement cp from containers

Downloading an image
--------------------

There are several images in joequant.  

* bitstation is a clean image
* bitstation-example has preincluded data

    docker pull joequant/bitstation
    docker tag joequant/bitstation bitstation
    run-docker.sh

The images assume that you have set up docker to be runnable by your
user account.  You can also set the environment variable SUDO to sudo
if you are running docker via root.

To build the image
------------------

    make

You may need to run make with "sudo make" if docker can only run under root

To run docker

    run-docker.sh

You can then connect to the system via the localhost port 80


Docker script from

https://raw.githubusercontent.com/joequant/docker-brew-mageia/master/mkimage-urpmi.sh

Troubleshooting
---------------

There appear to be some conflicts with drakfirewall.  You should open
the firewall before running docker.  Also you make have to restart the
docker after resetting the firewall.

