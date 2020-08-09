# Resolver (Standard Nameserver) festlegen

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