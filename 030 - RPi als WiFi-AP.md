# RPi als WiFi-AP

## WiFi Country Code setzen

* `$ sudo raspi-config`
* Unter `Localisation Options // Change WLAN Country` die Option `DE` für Deutschland wählen.

## Software installieren

```
$ sudo apt install hostapd
```

## WiFi-AP konfigurieren

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
Die WiFi-SID `NewWorldOrder` sollte während des Testlaufs beispielsweise auf einem Smartphone sichtbar sein.

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


## DHCP-Server und DNS-Cache für WiFi-AP konfigurieren
```
$ sudo nano /etc/dnsmasq.conf
```
