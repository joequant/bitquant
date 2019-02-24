#!/bin/python3
import cgi
import cgitb
import subprocess
cgitb.enable()

print("<pre>")
print(subprocess.check_output(['pip3', 'list']).decode('utf-8'))
print(subprocess.check_output(['npm', 'list', '-g']).decode('utf-8'))
print(subprocess.check_output('rpm -qa | sort', shell=True).decode('utf-8'))
print("</pre>")
