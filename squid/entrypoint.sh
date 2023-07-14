#!/bin/bash

/usr/local/squid/libexec/security_file_certgen -c -s /usr/local/squid/var/logs/ssl_db -M 20MB
mkdir -p /var/spool/squid && cd /var/spool/squid && mkdir -p  00  01  02  03  04  05  06  07  08  09  0A  0B  0C  0D  0E  0F && chmod 777 -R /var/spool/squid

exec /usr/local/squid/sbin/squid -f /usr/local/squid/etc/squid.conf -NYCd 1