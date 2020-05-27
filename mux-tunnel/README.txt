# mux-tunnel

Reverse-ssh-Tunnel zum Connecten auf den RPI über einen externen virtuellen Server.
Geht der Tunnel verloren, wird erneut versucht, die Verbindung aufzubauen.

## Vorteile dieser Variante

* abgestimmt auf die eingeschränkte DS-Lite-Konnektivität
* IP oder DNS-Name des RPI muss nicht bekannt sein.
* ssh ist trivial zu konfigurieren gegenüber einem tun/tap-Tunnel.
* tun/tap muss auf dem VServer nicht vorhanden sein.
* Ressourcenschonend, auf das Wesentliche konzentriert.
* Nutzung von Linux-Standardtools.

## Clientseitige Konfiguration (Rasperry Pi)

   $ sudo apt install tmux
   $ sudo apt install ssh
   $ adduser tunnel
   

* Ein RSA-Schlüsselpaar erzeugen.
* Die Dateien

  start-mux-tunnel.sh
  keep-mux-tunnel.sh
  
  in das Verzeichnis '/home/tunnel/' kopieren.

* Beide Dateien als Benutzer 'tunnel' ausführbar machen.
* Den Eintrag 'server=' mit dem Namen deines externen V-Servers ergänzen.


Serverseitige Konfiguration (externer V-Server)
-----------------------------------------------

* Einen Benutzer namens 'tunnel' anlegen.
* Einen ssh-Server installieren (müsste schon geschehen sein ;).
* Öffentlichen RSA-Schlüssel des Rasperry Pi importieren.
* Ssh-Server für die Authentifikation per RSA-PKI konfigurieren:
* Dafür folgende Einträge in der Datei '/etc/ssh/sshd_config' vornehmen:

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

# ACHTUNG:
# In diesem Beispiel sind alle Authentifikationen mit Ausnahme von
# 'PubkeyAuthentication' deaktiviert.


Grundlegende Benutzung
----------------------

Mit dem Befehl `~/start-mux-tunnel.sh` wird der ssh-Tunnel aufgebaut.

Per `tmux attach` kann der Status des Tunnels live begutachtet werden.

Innerhalb von tmux kann dann als Nutzer `tunnel` auf dem V-Server per ssh
gearbeitet werden.

Innerhalb von tmux kann das Terminal mit der Tastenfolge '[Ctrl-B] danach [D]'
verlassen werden. Der Tunnel bleibt nach dem Verlassen mit dieser
Tastenabfolge weiterhin bestehen.
