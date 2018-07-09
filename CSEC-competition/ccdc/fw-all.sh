# Clear rules and chains
iptables -F
iptables -X

# Default allow
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# Related connection in and out
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# ICMP IN
iptables -A INPUT -p ICMP -j ACCEPT

# HTTP Server
iptables -A INPUT -p TCP --dport 80 -j ACCEPT
# HTTPS Server
iptables -A INPUT -p TCP --dport 443 -j ACCEPT
# HTTP Client
iptables -A OUTPUT -p TCP --dport 80 -j ACCEPT
# HTTPS Client
iptables -A OUTPUT -p TCP --dport 443 -j ACCEPT

# MySQL client - grant user access on server if needed
iptables -A OUTPUT -p TCP --dport 3306 -j ACCEPT

# SSH Server
iptables -A INPUT -p TCP --dport 22 -j ACCEPT

# DNS Server
iptables -A INPUT -p UDP --dport 53 -j ACCEPT
iptables -A INPUT -i lo -p TCP --dport 953 -j ACCEPT # rndc 

# DNS Client
iptables -A OUTPUT -p UDP --dport 53 -j ACCEPT

# FTP Server - ENABLE ip_conntrack_ftp, nf_conntrack_ftp
iptables -A INPUT -p TCP --dport 21 -j ACCEPT
iptables -A OUTPUT -p TCP --sport 20 -j ACCEPT

# FTP Client
iptables -A OUTPUT -p TCP --dport 21 -j ACCEPT
iptables -A INPUT -p TCP --sport 20 -j ACCEPT

# Deny all others
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP

# Testing
 sleep 120
 iptables -F
