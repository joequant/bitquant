#!/bin/bash
dest=$1
iptables -t nat -F PREROUTING
iptables -t nat -F POSTROUTING
iptables -F FORWARD
iptables -A PREROUTING -t nat -i enp3s0 -p tcp --dport 80 -j DNAT --to $dest:80
iptables -A FORWARD -p tcp -d $dest --dport 80 -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE 
