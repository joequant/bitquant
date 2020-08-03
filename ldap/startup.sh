#!/bin/bash
echo "starting"
/usr/libexec/cockpit-ws --proxy-tls-redirect --no-tls --port 0 &
while :; do sleep 200000; done
