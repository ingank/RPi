mux-tunnel

Stabiler reverse-ssh-Tunnel zum Connecten auf den RPI über einen
externen virtuellen Server.

Vorteile dieser Variante:

- IP oder DNS-Name des RPI muss nicht bekannt sein.
- ssh ist trivial zu konfigurieren gegenüber einem tun/tap Tunnel.
- Ressourcenschonend, auf das Wesentliche konzentriert.

Clientseitige Abhängigkeiten und Voraussetzungen (Rasperry Pi):

- ein Benutzer namens 'tunnel' (benötigt keine root-Rechte)
- ssh-Client
- ein RSA-Schlüsselpaar
- tmux
- im Verzeichnis '/home/tunnel/' befinden sich die Dateien:

      start-mux-tunnel.sh
      keep-mux-tunnel.sh       

Serverseitige Abhängigkeiten (externer V-Server):

- ein Benutzer namens 'tunnel' (benötigt keine root-Rechte)
- ssh-Deamon
- öffentlicher RSA-Schlüssel des Rasperry Pi ist bekannt
- ssh-Zugriff per RSA-PKI ist konfiguriert
