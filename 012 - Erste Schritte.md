# Erste Schritte nach der Installation

## Booten

* Lege die SD-Card in den RaspberryPi ein und versorge ihn mit Betriebsspannung.
* Beim ersten Booten direkt nach der Installation des Betriebssystems RaspiOS wird die Größe der Systempartition automatisch an die Datenträgergröße angepasst.

## Erster SSH-Login

* Richte auf einem anderen Linux-Rechner eine IPv4 im Subnetz 192.168.100.0 auf dem Ethernet-Interface ein (beispielsweise 192.168.100.200).
* Öffne ein Terminal auf dem Linux-Rechner.
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

## SSH ausschließlich an das Servicenetzwerk binden

Da globale IPv6-Adressen unter Umständen (bei unvorsichtiger Konfiguration des Gateways)
direkt aus dem Internet geroutet werden können,
soll der SSH-Dämon in diesem frühen Stadium ausschließlich an das lokale Service-Subnetz 192.168.100.0 gebunden werden.
Zusätzliche Zugänge können später bei Bedarf hinzugefügt werden.

Diese Tätigkeit wird als **Benutzer mit root-Rechten** ausgeführt.
```
nano /etc/ssh/sshd_config
```
Im sich öffnenden nano-Editor werden folgende Einträge gesucht ('#') und geändert:
```
#AddressFamily any
AddressFamily inet
#ListenAddress 0.0.0.0
ListenAddress 192.168.100.100
```
**Achtung:** Ein Zugriff per `ssh pi@localhost` ist nun auch nicht mehr möglich!
