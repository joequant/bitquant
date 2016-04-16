Requirements
------------

The docker script requires docker 1.8 to implement cp from containers

Downloading an image
--------------------

The image for bitstation is stored on docker hub as joequant/bitstation

To run

    ./pull-docker-image.sh
    ./run-docker.sh

The images assume that you have set up docker to be runnable by your
user account.  You can also set the environment variable SUDO to sudo
if you are running docker via root.

You can then connect to the system via the localhost port 80

To build the image
------------------

    make

You may need to run make with "sudo make" if docker can only run under root

To run docker

    run-docker.sh

Notes
-----

The docker script to build a base mageia image is

https://raw.githubusercontent.com/joequant/docker-brew-mageia/master/mkimage-urpmi.sh

Troubleshooting
---------------

There appear to be some conflicts with drakfirewall.  You should open
the firewall before running docker.  Also you make have to restart the
docker after resetting the firewall.

