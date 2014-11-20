Downloading an image
--------------------

There are several images in joequant.  

* bitstation is a clean image
* bitstation-example has preincluded data

    docker pull joequant/bitstation
    docker tag joequant/bitstation bitstation
    run-docker.sh

To build the image
------------------

    make

You may need to run make with "sudo make" if docker can only run under root

To run docker

    run-docker.sh

You can then connect to the system via the localhost port 80


Docker script from

https://raw.githubusercontent.com/joequant/docker-brew-mageia/master/mkimage-urpmi.sh

