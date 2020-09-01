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

  pnpm run build

The system uses a podman/buildah toolchain to build an image.
However, right now there is a problem in using podman to run an image
with volumes because podman doesn't handle symlinks that go outside a
volume.

See: https://github.com/containers/podman/issues/6003

Proxy server
------------

   There is a docker image called joequant/cacher which sets up a
   caching server that includes squid and compile caching.  To run the
   cacher go to the repository joequant/cacher and run docker-compose.

   Cacher sets up a number of proxy and distccd caches that speed up
   compiles.

License
-------

Copyright (C) 2016-
Bitquant Research Laboratories (Asia) Limited

The contents of this directory are released under the terms of the GNU
Lesser General Public License.