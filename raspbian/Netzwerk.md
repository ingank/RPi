# Netzwerk einrichten

## `/etc/dhcpcd.conf`
```
# Zufälliger IPv6-Suffix
slaac private

# DNS-Server (bekanntgegeben über RAs)
# sollen nicht berücksichtigt werden:
noipv6rs

# Statische Konfiguration des LAN-Interfaces
interface eth0
static ip_address=192.168.0.20/24
static routers=192.168.0.1
static domain_name_servers=8.8.8.8
static domain_name_servers=2001:4860:4860::8888
static domain_name_servers=8.8.4.4
static domain_name_servers=2001:4860:4860::8844
```
