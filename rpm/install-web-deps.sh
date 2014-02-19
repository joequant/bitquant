#!/bin/bash
#
# Make is etherpad
# postgresql-devel for etherpad-lite

urpmi --no-suggests --auto python-flask apache apache apache-mod_wsgi \
ipython make postgresql-devel


