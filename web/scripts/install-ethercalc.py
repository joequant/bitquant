#!/usr/bin/env python3

import ethercalc
import os
import sys

cwd = os.path.dirname(os.path.realpath(sys.argv[0]))
ethercalc_dir = os.path.join(cwd, "ethercalc")
for i in os.listdir(ethercalc_dir):
    if i.endswith(".clc"):
        item = i.rsplit(".", maxsplit=1)[0]
        print(item)
    

