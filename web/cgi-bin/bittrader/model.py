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
import fcntl
import time

app = Flask(__name__)
default_password = "cubswin:)"
script_dir = os.path.dirname(os.path.realpath(__file__))

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
    timezone = request.form['timezone']
    if newpass1 != newpass2:
        return "passwords do not match"
    return subprocess.check_output(["./timezone.sh", timezone]) + \
           login.chpasswd(myuser, request.form['newpass1']) + "<br>\n" + \
           login.chpasswd("root", request.form['newpass1']) + "\n"

@app.route("/setup", methods= ['POST'])
def setup():
    if (not login.auth(user(), request.values['password'])):
        return "password invalid"
    submit = request.values['submit']
    if submit == "Startup servers":
        try:
            return subprocess.check_output(["./servers.sh", "/on"])
        except:
            return traceback.extract_stack()
    elif submit == "Shutdown servers":
        try:
            return subprocess.check_output(["./servers.sh", "/off"])
        except:
            return traceback.extract_stack()
    elif submit == "Set time zone":
        timezone = request.values['timezone']
        return subprocess.check_output(["./timezone.sh", timezone])
    elif submit == "Startup ssh":
        return subprocess.check_output(["./sshd.sh", "/on"])
    elif submit == "Shutdown ssh":
        return subprocess.check_output(["./sshd.sh", "/off"])
    elif submit == "Refresh CGI scripts":
        return refresh_scripts()
    elif submit == "Remove local install":
        return subprocess.check_output(["./clean-to-factory.sh"])
    else:
        return "unknown command"

def is_locked(tag):
    fp = open(os.path.join(bitquant_root(),
                           "web", "log",
                           tag + ".lock"), "w")
    try:
        fcntl.flock(fp, fcntl.LOCK_EX | fcntl.LOCK_NB)
        return False
    except IOError:
        return True


@app.route("/version/<tag>")
@app.route("/version")
def version(tag=None):
    os.chdir(bitquant_root())
    retval = {}
    if tag == "user" or tag == None:
        retval['user'] = user()
    if tag == "version" or tag == None:
        retval['version'] = \
                          subprocess.check_output(["git", "rev-parse",
                                                   "--short", "HEAD"]).strip();
    if tag == "bootstrap_finished" or \
           tag == "bootstrap_status" or tag == None:
        retval['bootstrap_finished'] = \
                               os.path.exists(os.path.join(bitquant_root(),
                                                           "web", "log",
                                                           "bootstrap.done"));
    if tag == "default_password" or tag == None:
        retval["default_password"] = login.auth(user(), default_password)
    if tag == "bootstrap_running" or \
           tag == "bootstrap_status" or tag == None:
        retval['bootstrap_running'] = is_locked("bootstrap")
    if tag == "timezone" or tag == None:
        for line in subprocess.check_output(['timedatectl',
                                              'status']).splitlines():
            if "Timezone:" in line:
                retval['timezone'] = line.strip().split()[1]
        if retval['timezone'] == "n/a":
            retval['timezone'] = subprocess.check_output(["grep",
                   "ZONE=",
                   "/etc/sysconfig/clock"]).strip().replace("ZONE=","")
    return Response(json.dumps(retval), mimetype='application/json')

def tail(f, n):
    assert n >= 0
    pos, lines = n+1, []
    while len(lines) <= n:
        try:
            f.seek(-pos, 2)
        except IOError:
            f.seek(0)
            break
        finally:
            lines = list(f)
            pos *= 2
    return lines[-n:]

@app.route("/bootstrap")
def bootstrap():
    os.system("./bootstrap.sh &")
    return "Bootstrap started"

@app.route("/log/<tag>")
def log(tag="bootstrap"):
    log_file= os.path.join(bitquant_root(),
                           "web", "bittrader", "log", tag + ".log")
    def generate():
        f = None
        with  open(log_file, "r") as f:
            for i in tail(f, 200):
                yield(i)
            if not is_locked("bootstrap"):
                return
            f.seek(0,2)      # Go to the end of the file
            while True:
                line = f.readline()
                if not line:
                    time.sleep(0.1)    # Sleep briefly
                    continue
                yield line
                if not is_locked("bootstrap"):
                    return
    return Response(generate(), mimetype="text/plain")

if __name__ == '__main__' and len(sys.argv) == 1:
    from wsgiref.handlers import CGIHandler
    CGIHandler().run(app)
elif __name__ == '__main__' and sys.argv[1] == "refresh-scripts":
    print refresh_scripts()
