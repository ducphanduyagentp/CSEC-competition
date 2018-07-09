#!/bin/bash

if [ ! -e /etc/bind/ ]; then
	mkdir /etc/bind
	touch /etc/bind/blacklisted.zones
fi

if [ ! -e /etc/bind/blocked.dns ]; then
	touch /etc/bind/blocked.dns
	cat <<EOT >> /etc/bind/blocked.dns
\$TTL	604800
@	IN	SOA	localhost. root.localhost. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	localhost.
@	IN	A	127.0.0.1
@	IN	AAAA	::1
EOT
fi

for domain; do
	echo "Blacklisting $domain...";
        cat <<EOT >> /etc/bind/blacklisted.zones
zone "$domain" { type master; file "/etc/bind/blocked.dns"; };
EOT
done

