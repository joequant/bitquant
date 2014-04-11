OZ scripts for creating disk images

The command is

./mkimg.sh <auto file> <format> <machine tdl file>

EXAMPLES

To generate a test development i586 image for Mageia

   ./mkimg.sh MageiaDev vdi mageia-cauldron-i586

The user is "user"  
Password is "cubswin:)"

Troubleshooting

* To generate i586 images you will need oz-0.12.0-3.mga5

* Make sure you have turned off your local firewall or else the
  installing image will not be able to see the remote servers.

* There seems to be problems directly creating a VDI file with the
  install kit for Mageia 4.  I've ended up with corrupted disk images.
  Things work when generating qcow2 files and then converting them to
  VDI.
