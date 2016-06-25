#!/bin/bash

rfkill block wifi

rfkill unblock wifi

# set up bridge
ip link add name br0 type bridge
ip link set br0 up
ip link set eth0 up
ip link set eth0 master br0

# Debug: list bridge
bridge link

ifconfig wlan0 down
ifconfig wlan0 192.168.42.1
ifconfig wlan0 up

sleep 1

service udhcpd start
hostapd -d /etc/hostapd/hostapd.conf
