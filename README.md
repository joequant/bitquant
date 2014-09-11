Bitquant
=================

Scripts and installation routines for Bitquant Research Laboratories
(Asia) Ltd.

In addition to paper drafts, this repository contains the script to
generate the diskimage for the bitstation trading system.  Bitstation
consists of a disk image which can be run in VirtualBox or uploaded to
a cloud computing system.

Generating disk image
=====================

To generate a disk image, type

   make

This will create a VDI disk image with bitquant software.  You can then
upload it to a cloud or run it locally with a VirtualBox.  

Running the system with virtualbox (windows/mac/linux)
===============================================

For a system  with zeroconf/bonjour, you can set your web server to

http://bitstation.lan/

For a system  without zeroconf, you can boot the image with VirtualBox
and the local IP of the system  will be displayed.  The default image
is configured to grab a local IP starting with http://192.168.56.100

The framework that I use to generate the image can be used for other
web appliances.

There are scripts in the directory "oz", that automate the process of
adding or removing images from VirtualBox

Running the system under LXC (linux)
===================================

To run the image under linux

   cd oz/lxc
   ./mountimg ~/.oz/images/<image name>
   ./mklxc
   ./umountimg

This will run the image in lxc with the contents of the system in the 
local system.  You will need "vdfuse" for this.  There is also an
alternative way of mounting a disk image which is commented out in 
mountimg.

The image will appear on the virbr0 device

http://192.168.122.1


Generate local install
======================

To install the system local, type

   make local

Set your web browser to

http://localhost/



