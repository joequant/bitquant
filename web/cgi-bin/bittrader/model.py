#!/usr/bin/python
from wsgiref.handlers import CGIHandler
from flask import Flask, Response, request
import subprocess
import sys
import shutil
import os
import json
import getpass
import login
import traceback

app = Flask(__name__)
default_password = "cubswin:)"

@app.route('/')
def index():
    return 'index'

@app.route('/foo')
def test():
    return 'test'

@app.route('/user')
def user():
    return getpass.getuser()

@app.route('/git-root')
def git_root():
    return os.path.expanduser(os.path.join("~", "git"))

@app.route('/bitquant-root')
def bitquant_root():
    return os.path.expanduser(os.path.join("~", "git", "bitquant"))

@app.route('/cgi-root')
def cgi_root():
    return "/var/www/cgi-bin/bittrader"

@app.route("/refresh-scripts")
def refresh_scripts():
    retval = "Refreshing scripts\n"
    local_cgi_path = os.path.join(bitquant_root(),
                                  "web", "cgi-bin", "bittrader")
    for file in os.listdir(cgi_root()):
        retval = retval + "removing old " + file + "\n"
        os.remove(os.path.join(cgi_root(), file))
    for file in os.listdir(local_cgi_path):
        if file.endswith(".sh") or file.endswith(".py"):
            shutil.copy2(os.path.join(local_cgi_path, file), cgi_root())
            os.chmod(os.path.join(cgi_root(), file), 0755)
            retval = retval + "copying " + file + "\n"
    return retval + "(done)"

@app.route("/passwd", methods = ['POST'])
def passwd():
    myuser = user()
    if (not login.auth(myuser, default_password)):
        return "Password not default"
    newpass1 = request.form['newpass1']
    newpass2 = request.form['newpass2']
    if newpass1 != newpass2:
        return "passwords do not match"
    return login.chpasswd(myuser, request.form['newpass1']) + "<br>\n" + \
           login.chpasswd("root", request.form['newpass1']) + "\n" 

@app.route("/version")
def version():
    os.chdir(bitquant_root())
    retval = {
        "user" : user(),
        "version" : subprocess.check_output(["git", "rev-parse",
                                             "--short", "HEAD"]).strip(),
        "bootstrapped" : os.path.exists(os.path.join(bitquant_root(),
                                                     "web", "bootstrap.done")),
        "default_password" : login.auth(user(), default_password)
        }
    return Response(json.dumps(retval), mimetype='application/json')

if __name__ == '__main__' and len(sys.argv) == 1:
    from wsgiref.handlers import CGIHandler
    CGIHandler().run(app)
elif __name__ == '__main__' and sys.argv[1] == "refresh-scripts":
    print refresh_scripts()
