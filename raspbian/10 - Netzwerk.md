# Netzwerk einrichten

## Resolver (Standard Nameserver) festlegen

Der RaspPi bezieht seine Resolver in der Grundeinstellung von DHCP-Servern
(IPv4/IPv6) und aus *Router Advertisements* (IPv6). Wer jedoch eigene oder
einfach nur andere Resolver nutzen möchte, muss etwas Hand anlegen.
Im folgenden Beispiel werden die Standard-Resolver auf einem RaspPi
dieser Änderung unterzogen.

Istzustand:
```
$ cat /etc/resolv.conf
# Generated by resolvconf
domain home
nameserver 192.168.0.1
nameserver 2a02:908:2:a::1
nameserver 2a02:908:2:b::1
```
Sollzustand:
```
$ cat /etc/resolv.conf
# Generated by resolvconf
domain home
nameserver 8.8.8.8
nameserver 2001:4860:4860::8888
nameserver 8.8.4.4
nameserver 2001:4860:4860::8844
```
Um die Datei /etc/resolv.conf dauerhaft zu ändern,
können wir den Dienst dhcpcd bemühen:
```
$ sudo su
> mv /etc/dhcpcd.conf /etc/dhcpcd.conf~
> echo static domain_name_servers=8.8.8.8 2001:4860:4860::8888 \
    8.8.4.4 2001:4860:4860::8844 > /etc/dhcpcd.conf
> systemctl restart dhcpcd
> cat /etc/resolv.conf
# Generated by resolvconf
domain home
nameserver 8.8.8.8
nameserver 2001:4860:4860::8888
nameserver 8.8.4.4
nameserver 2001:4860:4860::8844
nameserver 2a02:908:2:a::1
nameserver 2a02:908:2:b::1
```
Der ehemalige IPv4-Resolver 192.168.0.1,
bereitgestellt durch den DHCP-Server des Gateways,
wurde somit gnädigerweise schon eleminiert.
Nun geht es den beiden IPv6-Resolvern an den Kragen,
die per *Router Advertisement* hartnäckig ihren Weg in die /etc/resolv.conf
finden.
```
> echo name_server_blacklist=2a02:* >> /etc/resolvconf.conf
> resolvconf -u
```
Nach dem Neustart des RaspPi, sollten die eingangs gewünschten Resolver
(und ausschließlich diese)
in der Datei /etc/resolv.conf dauerhaft vermerkt sein.

## Statische IP-Adressen vergeben

Der DHCP-Server des lokalen Netzwerkes vergibt bereitwillig IP-Adressen aus seinem Adresspool.
Auch der RaspPi bezieht in der Grundkonfiguration seine IP-Adresse(n) auf diese Weise.

Soll der RaspPi eine oder auch viele statische IP's zugewiesen bekommen,
kann dies wiedrum über den schon bekannten Dienst dhcpcd geschehen.

Istzustand:
```
$ ip -f inet a s eth0 | grep inet
    inet 192.168.100.100/24 brd 192.168.100.255 scope global eth0
    inet 192.168.0.20/24 brd 192.168.0.255 scope global dynamic noprefixroute eth0
$ ip route
default via 192.168.0.1 dev eth0 proto dhcp src 192.168.0.20 metric 202
192.168.0.0/24 dev eth0 proto dhcp scope link src 192.168.0.20 metric 202
192.168.100.0/24 dev eth0 proto kernel scope link src 192.168.100.100
```
Sollzustand:
```
$ ip -f inet a s eth0 | grep inet
    inet 192.168.100.100/24 brd 192.168.100.255 scope global eth0
    inet 192.168.0.100/24 brd 192.168.0.255 scope global noprefixroute eth0
$ ip route
default via 192.168.0.1 dev eth0 src 192.168.0.100 metric 202 
192.168.0.0/24 dev eth0 proto dhcp scope link src 192.168.0.100 metric 202 
192.168.100.0/24 dev eth0 proto kernel scope link src 192.168.100.100 
```
Vorgehen:
```
$ sudo nano /etc/dhcpcd.conf

# Drei Zeilen hinzufügen:

interface eth0
static ip_address=192.168.0.100/24
static routers=192.168.0.1

$ sudo systemctl restart dhcpcd
```

## IPv6 Privacy Extensions (wieder) aktivieren

Durch das radikale Löschen der originalen /etc/dhcpcd.conf weiter oben in diesem
Tutorial, wurden auch die IPv6 Privacy Extensions vorübergehend auch wegrationalisiert.
Die (Wieder-) Aktivierung stellt jedoch keine große Hürde dar:
```
$ sudo su; echo slaac private >> /etc/dhcpcd.conf
> systemctl daemon-reload
> systemctl restart dhcpcd
```