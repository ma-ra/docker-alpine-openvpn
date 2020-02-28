#!/bin/sh
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -I PREROUTING -d 172.17.0.1/32 -p tcp -m tcp --dport 3128 -j DNAT --to-destination $(/usr/bin/awk ' /squid/ { print $1 } ' /etc/hosts):3128
iptables -t nat -I PREROUTING -d 172.17.0.1/32 -p tcp -m tcp --dport 53 -j DNAT --to-destination $(/usr/bin/awk ' /localbind/ { print $1 } ' /etc/hosts):53
iptables -t nat -I PREROUTING -d 172.17.0.1/32 -p udp -m udp --dport 53 -j DNAT --to-destination $(/usr/bin/awk ' /localbind/ { print $1 } ' /etc/hosts):53
exec /usr/sbin/openvpn --cd /etc/openvpn/ --config server.conf
