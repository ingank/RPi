# Raspbian installieren

Führe auf einem Ubuntu-Desktop-System nacheinander folgende Schritte aus:

* Lade das neueste Raspbian (Lite) herunter.
* Entpacke die .zip-Datei.
* Lege eine SD-Card ein.
* Starte 'Anwendungen anzeigen' -> 'Hilfsprogramme' -> 'Laufwerke'.
* Markiere das Laufwerk für die SD-Card.
* Gehe zu 'Drei waagerechte Striche' oben Links im Programmfenster.
* Klicke 'Laufwerksabbild wiederherstellen...'.
* Wähle im Dialog die entpackte .img-Datei.
* Klicke 'Wiederherstellung starten'.

Nach ca. 2 Minuten sollte das Image auf die SD-Card geschrieben sein.

* Markiere die nun vorhandene boot-Partition.
* Klicke Dreieck für 'Ausgewählte Partition einhängen'.
* Klicke auf den blau gefärbten Link hinter 'Eingehängt in'.

Im Dateimananger werden die Dateien der boot-Partition aufgelistet.

* Rechtsklick in freien Ordnerbereich -> 'In Terminal öffnen'.
* Im Terminal eingeben: `$ sudo touch ssh`
* Anfügen an Datei 'cmdline.txt': `ip=192.168.100.100:::255.255.255.0::eth0:off`
* Alle Dateien und Programme schließen, die auf die boot-Partition zugreifen.
* Klicke auf Quadrat im Programm 'Laufwerke' um die boot-Partition auszuhängen.
* Lege SD-Card in den RaspberryPi ein und versorge ihn mit Betriebsspannung.
* Richte auf dem Ubuntu-Rechner eine zweite IPv4 (beispielsweise 192.168.100.200) auf dem Ethernet-Interface ein.

Bemerkung: Das Netzwerksegment 192.168.100.0 wird hier unabhängig vom meist genutzen 192.168.0.0 für administrative Aufgaben verwendet. Da die IPv4 192.168.100.100 direkt über einen Kernel-Paramter erzeugt wird, ist eine missliche Konfiguration über die üblichen Systemwerkzeuge hoffentlich ausgeschlossen.

* Öffne einen Terminal auf dem Ubuntu-Rechner.
* Im Terminal eingeben: `$ ssh pi@192.168.100.100`
* Das Standardpasswort lautet: **raspberry**
* Ändere, sobald die Verbindung steht, das voreingestellte Passwort mit `$ passwd`.

