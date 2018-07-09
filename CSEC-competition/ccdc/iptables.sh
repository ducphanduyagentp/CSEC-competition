#!/bin/sh

#Clear Tables
iptables -F

#Default, anti-lockout
iptabes -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

#Related & Established
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

#Loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -i lo -j ACCEPT

#ICMP
iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -A OUTPUT - p icmp --icmp-type 8 -j ACCEPT

#Web-Server http
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 -J ACCEPT

#Web-Server https
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 443 -j ACCEPT

#Web-Client http
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT

#Web-Client https
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT

#SSH-Server
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

#SSH-Client
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT

#FTP-Server
iptables -A INPUT -p tcp --dport 20 -j ACCEPT
iptables -A INPUT -p tcp --dport 21 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 20 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 21 -j ACCEPT

#FTP-Client
iptables -A OUTPUT -p tcp --dport 20 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 21 -j ACCEPT

#DNS-Server
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 53 -j ACCEPT
iptables -A OUTPUT -p udp --sport 53 -j ACCEPT

#DNS-Client
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

#Drop all else
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
