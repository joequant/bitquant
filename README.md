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

Set your web browser to

http://bitstation.lan/

The framework that I use to generate the image can be used for other
web appliances.

Generate local install
======================

To install the system local, type

   make local

Set your web browser to

http://localhost/



