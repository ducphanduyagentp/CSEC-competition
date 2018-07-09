#!/bin/sh

# Clear rules and chains
iptables -F
iptables -X

# Default allow
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT

# Related connection out
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow ICMP
iptables -A INPUT -p ICMP -j ACCEPT

# Allow HTTP
iptables -A INPUT -p TCP --dport 80 -j ACCEPT
iptables -A INPUT -p TCP --dport 443 -j ACCEPT

# Allow SSH
iptables -A INPUT -p TCP -m iprange --src-range 1.2.3.4-5.6.7.8 --dport 22 -j ACCEPT

# Allow DNS
iptables -A OUTPUT -p UDP --dport 53 -j ACCEPT
#iptables -A INPUT -p UDP --dport 53 -j ACCEPT

# Deny all other
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP

# Testing
sleep 100
iptables -F
