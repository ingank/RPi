# TODO

* Nameserver per dnsmasq
* DHCPD per dnsmasq
* DNS-Tunnel (ssh) auf externen VServer

# CONFIG

### /etc/resolvconf.conf
```
resolv_conf=/etc/resolv.conf
dnsmasq_resolv=/var/run/dnsmasq/resolv.conf
pdnsd_conf=/etc/pdnsd.conf
unbound_conf=/var/cache/unbound/resolvconf_resolvers.conf
name_server_blacklist=2a*
```
### /etc/dhcpcd.conf
```
slaac private
static domain_name_servers=8.8.8.8 2001:4860:4860::8888 8.8.4.4 2001:4860:4860::8844
interface eth0
static ip_address=192.168.0.100/24
static routers=192.168.0.1
```
### /etc/dnsmasq.conf
```
listen-address=127.0.0.1
listen-address=192.168.0.100
no-dhcp-interface=127.0.0.1
no-dhcp-interface=192.168.0.100
bind-interfaces
dhcp-mac=set:client_is_a_pi,B8:27:EB:*:*:*
dhcp-reply-delay=tag:client_is_a_pi,2
```
### /etc/network/interfaces.d/eth0-foo
```
auto eth0
allow-hotplug eth0
iface eth0 inet static
    address 192.168.0.101
    netmask 255.255.255.0
    gateway 192.168.0.1
iface eth0 inet static
    address 192.168.0.102
    netmask 255.255.255.0
    gateway 192.168.0.1
```
### /etc/ssh/sshd_config
```
AddressFamily inet
ListenAddress 127.0.0.1
ListenAddress 192.168.0.100
ListenAddress 192.168.100.100
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem	sftp	/usr/lib/openssh/sftp-server
```
