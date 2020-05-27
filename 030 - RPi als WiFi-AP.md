# RPi als WiFi-AP

## Notwendige Software installieren

```
$ sudo apt install hostapd
```

## WiFi Country Code setzen

* `$ sudo raspi-config`
* Unter `Localisation Options // Change WLAN Country` die Option `DE` für Deutschland wählen.

## WLAN-Interface des WiFi-APs konfigurieren
```
$ sudo nano /etc/dhcpcd.conf
```
Folgende Zeilen hinzufügen:
```
interface wlan0
static ip_address=192.168.1.1/24
```
Mit [Strg+S] und danach [Strg+X] speichern und beenden.  
Danach den Sytemdienst dhcpcd neu starten:
```
$ sudo systemctl daemon-reload
$ sudo systemctl restart dhcpcd
```

## WiFi-Host konfigurieren

```
$ sudo nano /etc/hostapd/hostapd.conf
```
In diese Datei wird folgende Konfiguration geschrieben:
```
interface=wlan0

ssid=NewWorldOrder
channel=1
hw_mode=g
ieee80211n=1
ieee80211d=1
country_code=DE
wmm_enabled=1

auth_algs=1
wpa=2
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
wpa_passphrase=DasGehtJaMalGarnich
```
Nur für `root` lesbar machen:
```
sudo chmod 600 /etc/hostapd/hostapd.conf
```
Konfiguration testen ( Mit [Strg+C] abbrechen ):
```
sudo hostapd -dd /etc/hostapd/hostapd.conf
```
Während dieses Testlaufes sollten folgende Prüfungen positiv ausfallen:

* Ist die WiFi-SID `NewWorldOrder` als WLAN auf einem Smartphone sichtbar?
* Ist die IP 192.168.1.1 an das Interface `wlan0` gebunden? Dazu `ip s a` in einem zweiten Terminal ausführen.

Wenn die Prüfungen erfolgreich waren, kann `hostapd` permanent gemacht werden:
```
sudo nano /etc/default/hostapd
```
Folgende Zeilen anfügen:
```
RUN_DAEMON=yes
DAEMON_CONF="/etc/hostapd/hostapd.conf"
```
Dienst starten und auf Autostart:
```
$ sudo systemctl unmask hostapd
$ sudo systemctl start hostapd
$ sudo systemctl enable hostapd
```
Nach einem Neustart des Betriebssytems, sollte der hostapd gestartet und das WLAN-Interface die richtige IP aufweisen.

## DHCP-Server und DNS-Cache für WiFi-AP konfigurieren
```
$ sudo nano /etc/dnsmasq.conf
```
Die neue komplette `dnsmasq.conf` schaut jetzt folgendermaßen aus:
```
interface wlan0

listen-address=127.0.0.1
listen-address=192.168.0.100

no-dhcp-interface=eth0
no-dhcp-interface=127.0.0.1

bind-interfaces

dhcp-range=192.168.1.100,192.168.1.200,255.255.255.0,24h
dhcp-option=option:dns-server,192.168.1.1

dhcp-mac=set:client_is_a_pi,B8:27:EB:*:*:*
dhcp-reply-delay=tag:client_is_a_pi,2
```
