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
* Anfügen an Datei 'cmdline.txt': `ip=192.168.100.100:::255.255.255.0::eth0:on`

Der RaspberryPi ist ab sofort immer unter der Notfall-IP 192.168.100.100 erreichbar.
