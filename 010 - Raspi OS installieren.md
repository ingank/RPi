# Raspberry Pi OS installieren

Diese Kurzanleitung beschreibt die Installation von RaspiOS auf einer SD-Karte,
die Grundkonfiguration ''out of the box'' und die Tätigkeiten während/nach dem ersten Booten.

## Betriebssystemdatenträger erstellen

Führe auf einem Ubuntu-Desktop-System nacheinander folgende Schritte aus:

* Lade das neueste Raspberry Pi OS herunter.
* Entpacke die .zip-Datei.
* Lege eine SD-Card ein.
* Starte 'Anwendungen anzeigen' -> 'Hilfsprogramme' -> 'Laufwerke'.
* Markiere das Laufwerk für die SD-Card.
* Gehe zu 'Drei waagerechte Striche' oben rechts im Programmfenster.
* Klicke 'Laufwerksabbild wiederherstellen...'.
* Wähle im Dialog die entpackte .img-Datei.
* Klicke 'Wiederherstellung starten'.
* Nach ca. 2 Minuten sollte das Image auf die SD-Card geschrieben sein.
* Partition 'boot' und 'rootfs' aushängen.
* SD-Karte entnehmen.

## Grundkonfiguration ''out of the box''

Der RasPi kann ohne Bildschirm und Eingabegeräte betrieben werden (Headless).
Dazu muss schon vor dem ersten Booten direkt auf dem Betriebssystemdatenträger (out of the box) der Netzwerkzugriff konfiguriert werden.

Wir bleiben im Programm Laufwerke und führen folgende Tätigkeiten durch:

* SD-Karte wieder einlegen.
* boot-Partition markieren.
* Dreieck klicken für 'ausgewählte Partition einhängen'.
* Auf den blau gefärbten Link hinter 'Eingehängt in' klicken.
* In dem sich öffnenden Dateimananger wird die eingehängte boot-Partition angezeigt.
* Rechtsklick in freien Ordnerbereich -> 'In Terminal öffnen'.

### SSH aktivieren

```
touch ssh
```

### Eine feste IP-Adresse an das eth0-Interface binden

```
echo "$(cat ./cmdline.txt) ip=192.168.100.100:::255.255.255.0::eth0:off" > ./cmdline.txt
```

Bemerkung:  
Das Netzwerksegment 192.168.100.0 wird in diesem Beispiel unabhängig vom meist genutzen 192.168.0.0 für administrative Aufgaben verwendet.
Da die IPv4-Adresse 192.168.100.100 direkt über einen Kernel-Boot-Paramter an eth0 gebunden wird,
ist der RasPi hoffentlich auch dann über diese Adresse erreichbar,
wenn sich der Administrator durch eine missliche Netzwerkkonfiguration beispielsweise nach einem Reboot ausgeschlossen hat. 

Weiterführende Informationen zum Kernel-Paramter 'ip=':
* [Dokumentation auf kernel.org](https://www.kernel.org/doc/html/latest/admin-guide/nfs/nfsroot.html#kernel-command-line)
* [deutschsprachiges Dokument zum Thema](http://www.netzmafia.de/skripten/hardware/RasPi/RasPi_Install.html#initip)

### WLAN aktivieren

```
nano ./wpa_supplicant.conf
```

Im sich öffnenden Nano-Editor wird folgende Konfiguration eingegeben:

```
ctrl_interface=DIR=/var/run/wpa_supplicant
GROUP=netdev
update_config=1
country=DE

network={
 ssid="<Name of your wireless LAN>"
 psk="<Password for your wireless LAN>"
 key_mgmt=WPA-PSK
}
```

---

Nach der Konfiguration 'out of the box':

* Partition 'boot' und 'rootfs' aushängen.
* SD-Karte entnehmen.

## Erstes Booten des RaspberryPi und Zugriff mittels ssh

* Lege SD-Card in den RaspberryPi ein und versorge ihn mit Betriebsspannung.
* Richte auf dem Ubuntu-Rechner eine zweite IPv4 (beispielsweise 192.168.100.200) auf dem Ethernet-Interface ein.
* Öffne einen Terminal auf dem Ubuntu-Rechner.
* Im Terminal eingeben: `ssh pi@192.168.100.100`
* Das Standardpasswort lautet: **raspberry**

## Standardpasswort ändern

Direkt nach dem ersten Login wird das voreingestellte Passwort geändert:

```
pi@raspberrypi:~ $ passwd
Changing password for pi.
Current password: 
New password: 
Retype new password: 
passwd: password updated successfully
```
