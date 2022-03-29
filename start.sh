#!/bin/sh

# setup list of monitored ups hosts
if [ -f /etc/nut/hosts.conf.original ]; then
	cp /etc/nut/hosts.conf.original /etc/nut/hosts.conf
	
	IFS=';'
	for host in $NUT_HOSTS
	do
	    echo "${host}" >> /etc/nut/hosts.conf
	done
fi

# run the fcgiwrap daemon
printf "Starting up the fcgiwrap daemon ...\n"
service fcgiwrap start || { printf "ERROR on daemon startup.\n"; exit; }

# run nginx
printf "Starting up the web server ...\n"
exec nginx -g 'daemon off;'
