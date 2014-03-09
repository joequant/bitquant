#!/usr/bin/python
from wsgiref.handlers import CGIHandler
from flask import Flask
import subprocess
import sys
import shutil
import os
app = Flask(__name__)

@app.route('/')
def index():
    return 'index'

@app.route('/foo')
def test():
    return 'test'

@app.route('/git-root')
def git_root():
    return os.path.expanduser(os.path.join("~", "git", "bitquant"))

@app.route('/cgi-root')
def cgi_root():
    return "/var/www/cgi-bin/bittrader"

@app.route("/refresh-scripts")
def refresh_scripts():
    retval = "Refreshing scripts\n"
    local_cgi_path = os.path.join(git_root(),
                                  "web", "cgi-bin", "bittrader")
    for file in os.listdir(cgi_root()):
        retval = retval + "removing old " + file + "\n"
        os.remove(os.path.join(cgi_root(), file))
    for file in os.listdir(local_cgi_path):
        if file.endswith(".sh") or file.endswith(".py"):
            shutil.copy2(os.path.join(local_cgi_path, file), cgi_root())
            retval = retval + "copying " + file + "\n"
    return retval + "(done)"


@app.route("/version")
def version():
    os.chdir(git_root())
    return subprocess.check_output(["git", "rev-parse", "--short", "HEAD"])


if __name__ == '__main__' and len(sys.argv) == 1:
    from wsgiref.handlers import CGIHandler
    CGIHandler().run(app)
elif __name__ == '__main__' and sys.argv[1] == "refresh-scripts":
    print refresh_scripts() + "\n"
