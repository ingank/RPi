# Raspbian als Betriebssystem

## Installation

### Raspbian-Image auf SD-Card schreiben

Führe auf einem Ubuntu-Desktop-System nacheinander folgende Schritte aus:

* Lade das neueste Raspbian (Lite) herunter.
* Entpacke zip-Datei.
* Lege eine SD-Card ein.
* Starte 'Anwendungen anzeigen' -> 'Hilfsprogramme' -> 'Laufwerke'.
* Markiere das Laufwerk für die SD-Card.
* Gehe zu 'Drei waagerechte Striche' oben Links im Programmfenster.
* Klicke 'Laufwerksabbild wiederherstellen...'.
* Wähle im Dialog die entpackte img-Datei.
* Klicke 'Wiederherstellung starten'.

Nach ca. 2 Minuten sollte das Image auf die SD-Card geschrieben sein.

* Markiere die nun vorhandene boot-Partition.
* Klicke Dreieck für 'Ausgewählte Partition einhängen'.
* Klicke auf den blau gefärbten Link hinter 'Eingehängt in'.

Im Dateimananger werden die Dateien der boot-Partition aufgelistet.

* Rechtsklick in d freien Ordnerbereich -> 'In Terminal öffnen'.
* Im Terminal eingeben: `$ sudo touch ssh`
* Anfügen an Datei 'cmdline.txt': `ip=192.168.100.100:::255.255.255.0::eth0:off`
* Alle Dateien und Programme schließen, die auf die boot-Partition zugreifen.
* Klicke auf Quadrat im Programm 'Laufwerke' um die boot-Partition auszuhängen.
* SD-Card in den RaspberryPi einlegen und starten.

Der RaspberryPi ist ab sofort unter der IP 192.168.100.100 per ssh erreichbar.
Voraussetzung ist, dass der zugreifende Rechner eine IP im gleichen Netzwerksegment
(192.168.100.0) besitzt (beispielsweise 192.168.100.200).

Jetzt kann die erste ssh-Verbindung aufgebaut werden:

```
$ ssh pi@192.168.100.100
The authenticity of host '192.168.100.100 (192.168.100.100)' can't be established.
ECDSA key fingerprint is SHA256:FYX43uLmsBdUrpUB9j52PY71xUta7I88c4bUCmBMdC0.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.100.100' (ECDSA) to the list of known hosts.
pi@192.168.100.100's password: 
Linux raspberrypi 4.19.97-v7+ #1294 SMP Thu Jan 30 13:15:58 GMT 2020 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.

SSH is enabled and the default password for the 'pi' user has not been changed.
This is a security risk - please login as the 'pi' user and type 'passwd' to set a new password.


Wi-Fi is currently blocked by rfkill.
Use raspi-config to set the country before use.
```
