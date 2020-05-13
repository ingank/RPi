#!/bin/bash

# hier wird der Name des externen V-Servers eingetragen:
server=server.domain.tld

while true
do
    echo -e "\n\n---" | tee -a ./tunnel.log
    date | tee -a ./tunnel.log
    echo -e "---\n\n" | tee -a ./tunnel.log
    ssh -6 -v \
        -R [::1]:2222:[::1]:2222 \
        -o ServerAliveInterval=180 \
        -o ServerAliveCountMax=3 \
        tunnel@${server} \
        2>>./tunnel.log
	sleep  180
done
