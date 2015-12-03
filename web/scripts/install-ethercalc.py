#!/usr/bin/env python3

import ethercalc
import os
import sys
import requests

cwd = os.path.dirname(os.path.realpath(sys.argv[0]))
ethercalc_dir = os.path.join(cwd, "ethercalc")
ec = ethercalc.EtherCalc("http://localhost/calc/")
for i in os.listdir(ethercalc_dir):
    if i.endswith(".clc"):
        item = i.rsplit(".", maxsplit=1)[0]
        try:
            a = ec.export(i)
        except requests.exceptions.HTTPError:
            txt = open(os.path.join(ethercalc_dir, i))
            data = txt.read()
            print (data)
#            print (ec.update(item, data))


