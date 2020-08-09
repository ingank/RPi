# Statische IP-Adressen vergeben

Der DHCP-Server des lokalen Netzwerkes vergibt bereitwillig IP-Adressen aus seinem Adresspool.
Auch der RaspPi bezieht in der Grundkonfiguration seine IP-Adresse auf diese Weise.

### Eine einzelne IP-Adresse statisch zuweisen

Soll der RaspPi eine statische IP zugewiesen bekommen,
kann dies über den schon bekannten Dienst dhcpcd geschehen.

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

### Mehr als eine IP-Adresse statisch zuweisen

Soll mehr als eine IP-Adresse pro Interface gebunden werden,
können die zusätzlichen Adressen über die Dateien in /etc/network/interfaces.d/* konfiguriert werden.
Im folgenden Beispiel werden zwei zusätzliche IP-Adressen an das Interface eth0 gebunden:
```
$ sudo nano /etc/network/interfaces.d/eth0-foo
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
Die Adressen stehen nach einem Neustart des RaspPi bereit.
