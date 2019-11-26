#/bin/bash
cp squid/* /etc/squid
dnf install squid python3-pip
pip3 install devpi-server
npm install -g git-cache-http-server verdaccio
