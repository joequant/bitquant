#!/bin/bash
#
# Make is etherpad

urpmi --no-suggests --auto python-flask apache apache apache-mod_wsgi ipython \
make

