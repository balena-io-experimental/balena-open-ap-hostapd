#!/bin/bash

rfkill block wifi

rfkill unblock wifi

ifconfig wlan0 down
ifconfig wlan0 192.168.42.1
ifconfig wlan0 up

# Traffic forwarding
iptables -P FORWARD ACCEPT
iptables -F FORWARD
sysctl net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

sleep 1

service udhcpd start
hostapd -d /etc/hostapd/hostapd.conf
