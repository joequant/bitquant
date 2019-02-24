#!/bin/python3
import cgi
import cgitb
import subprocess
cgitb.enable()

def run_subprocess(arg, **kwargs):
    try:
        print(subprocess.check_output(arg, **kwargs).decode('utf-8'))
    except subprocess.CalledProcessError:
        pass

print("Content-type: text/html\n")
print("<pre>")

run_subprocess(['pip3', 'list'])
run_subprocess(['npm', 'list', '-g'])
run_subprocess('rpm -qa | sort', shell=True)
print("</pre>")
