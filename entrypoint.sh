#!/bin/sh
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
exec /usr/sbin/openvpn --cd /etc/openvpn/ --config server.conf
