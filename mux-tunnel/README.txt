==========
mux-tunnel
==========

Stabiler reverse-ssh-Tunnel zum Connecten auf den RPI über einen
externen virtuellen Server.


Vorteile dieser Variante
------------------------

- abgestimmt auf die eingeschränkte DS-Lite-Konnektivität
- IP oder DNS-Name des RPI muss nicht bekannt sein.
- ssh ist trivial zu konfigurieren gegenüber einem tun/tap-Tunnel.
- Ressourcenschonend, auf das Wesentliche konzentriert.


Clientseitige Abhängigkeiten und Voraussetzungen (Rasperry Pi)
--------------------------------------------------------------

- ein Benutzer namens 'tunnel' (benötigt keine root-Rechte)
- ssh-Client
- ein RSA-Schlüsselpaar
- tmux
- im Verzeichnis '/home/tunnel/' befinden sich die Dateien:

      start-mux-tunnel.sh
      keep-mux-tunnel.sh       


Serverseitige Abhängigkeiten (externer V-Server)
------------------------------------------------

- ein Benutzer namens 'tunnel' (benötigt keine root-Rechte)
- ssh-Deamon
- öffentlicher RSA-Schlüssel des Rasperry Pi ist bekannt
- ssh-Zugriff per RSA-PKI ist konfiguriert


Clientseitige Konfiguration
---------------------------

In der Datei `keep-mux-tunnel.sh` muss unter `server`
der Name des externen V-Servers eingetragen werden.


Serverseitige Konfiguration
---------------------------

Einträge in der Datei /etc/ssh/sshd_config:

GatewayPorts clientspecified
ClientAliveInterval 180
ClientAliveCountMax 3
Subsystem sftp /usr/lib/openssh/sftp-server
AcceptEnv LANG
AcceptEnv LC_*
PrintMotd yes
PermitRootLogin no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
GSSAPIAuthentication no
HostbasedAuthentication no
KbdInteractiveAuthentication no
KerberosAuthentication no
PasswordAuthentication no
PubkeyAuthentication yes
UsePAM no
AllowUsers tunnel


Benutzung
---------

Mit dem Befehl `~/start-mux-tunnel.sh` wird der ssh-Tunnel aufgebaut.

Per `tmux attach` kann der Status des Tunnels live begutachtet werden.

Innerhalb von tmux kann dann als Nutzer `tunnel` auf dem V-Server per ssh
gearbeitet werden.

Innerhalb von tmux kann das Terminal per [Ctrl-B] und danach [D] verlassen werden.
Der Tunnel bleibt innerhalb des tmux-Servers weiterhin bestehen.
