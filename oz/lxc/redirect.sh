iptables -t nat -F PREROUTING
iptables -t nat -F POSTROUTING
iptables -F FORWARD
iptables -A PREROUTING -t nat -i enp3s0 -p tcp --dport 80 -j DNAT --to 192.168.122.225:80
iptables -A FORWARD -p tcp -d 192.168.1.225 --dport 80 -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE 
