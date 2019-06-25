Requirements
------------

The docker script requires docker 1.8 to implement cp from containers

Running an image
----------------

To run

    docker-compose up

The image for bitstation is stored on docker hub as
joequant/bitstation which will be downloaded automatically by the
script.

The default user and password are "user" and "cubswin:)"

The scripts assume that you have set up docker to be runnable by your
user account.  You can also set the environment variable SUDO to sudo
if you are running docker via root.

You can then connect to the system via the localhost port 80

To build the image locally
--------------------------

    make

You may need to run make with "sudo make" if docker can only run under root

Notes
-----

The docker script to build a base mageia image is

https://raw.githubusercontent.com/joequant/docker-brew-mageia/master/mkimage-urpmi.sh

Troubleshooting
---------------

There appear to be some conflicts between docker networking and
firewalls.  You should open the port 80 to the docker network before
running docker.  Also you make have to restart the docker after
resetting the firewall.

The default build loads in tensorflow and so will die on a non-AVX
machine.  You will need to set the environment variable NOAVX in 03.setup
to install an image that will work for SSE4, AVX machines.

Proxy server
------------
1) Uncomment the proxy items
2) Run squid
3) install and run devpi-server from pypi
4) install git-cache-http-server with npm on squid server

License
-------

Copyright (C) 2016-
Bitquant Research Laboratories (Asia) Limited

The contents of this directory are released under the terms of the GNU
Lesser General Public License.