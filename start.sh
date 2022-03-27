#!/bin/sh

# setup list of monitored ups hosts
cp /etc/nut/hosts.conf.original /etc/nut/hosts.conf

IFS=';'
for host in $NUT_HOSTS
do
    echo "${host}" >> /etc/nut/hosts.conf
done

/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf
