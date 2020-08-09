# mux-ssh-Tunnel

Reverse-ssh-Tunnel zum Connecten auf den RPI über einen externen virtuellen Server.
Geht der Tunnel verloren, wird erneut versucht, die Verbindung aufzubauen.

## Vorteile dieser Variante

* abgestimmt auf die eingeschränkte DS-Lite-Konnektivität
* IP oder DNS-Name des RPI muss nicht bekannt sein.
* ssh ist trivial zu konfigurieren gegenüber einem tun/tap-Tunnel.
* tun/tap muss auf dem VServer nicht vorhanden sein.
* Ressourcenschonend, auf das Wesentliche konzentriert.
* Nutzung von Linux-Standardtools.

## Nachteile dieser Variante

* kein echtes VPN

## Clientseitige Konfiguration (Rasperry Pi)

* Paket tmux installieren
* Einen Benutzer namens `tunnel` anlegen
* Als Benutzer `tunnel` ein RSA-Schlüsselpaar erzeugen:
  * `$ ssh-keygen -t rsa -b 4096`
* Die Dateien `start-mux-tunnel.sh` und `keep-mux-tunnel.sh` in das Verzeichnis `/home/tunnel/` kopieren.
* Beide Dateien als Benutzer `tunnel` ausführbar machen.
* In `~/keep-mux-tunnel.sh` unter `server=` den Namen des externen V-Servers eintragen.

### `/home/tunnel/start-mux-tunnel.sh`

```
#!/bin/bash

sleep 3
tmux new-session -d -s tunnelmux
sleep 1
tmux send-keys '/home/tunnel/keep-mux-tunnel.sh' C-m
```

### `/home/tunnel/keep-mux-tunnel.sh`

```
#!/bin/bash

# hier wird der Name des externen V-Servers eingetragen:
server=server.domain.tld

while true
do
    echo -e "\n\n---" | tee -a ./tunnel.log
    date | tee -a ./tunnel.log
    echo -e "---\n\n" | tee -a ./tunnel.log
    ssh -6 -v \
        -R [::1]:2222:[::1]:2222 \
        -o ServerAliveInterval=180 \
        -o ServerAliveCountMax=3 \
        tunnel@${server} \
        2>>./tunnel.log
	sleep  180
done
```

### `/etc/ssh/ssh_config`
```
# Mindest-Konfiguration
Host *
    SendEnv LANG LC_*
    GSSAPIAuthentication yes
    ServerAliveInterval=180
    ServerAliveCountMax=3
```

## Serverseitige Konfiguration (externer V-Server)

* Einen Benutzer namens 'tunnel' anlegen.
* Öffentlichen RSA-Schlüssel des Rasperry Pi importieren.

### `/etc/ssh/sshd_config`:
```
# Mindest-Konfiguration
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
```
##### ACHTUNG

In diesem Beispiel sind alle Authentifikationen mit Ausnahme von `PubkeyAuthentication` deaktiviert.
Ein Login, beispielsweise per Passwort, ist dann nicht mehr möglich.

## Grundlegende Benutzung

* Mit dem Befehl `~/start-mux-tunnel.sh` wird der ssh-Tunnel aufgebaut.
* Per `tmux attach` kann der Status des Tunnels live begutachtet werden.
* Innerhalb von tmux kann dann als Nutzer `tunnel` auf dem V-Server per ssh gearbeitet werden.
* Innerhalb von tmux kann das Terminal mit der Tastenfolge '[Ctrl-B] danach [D]' verlassen werden.
  Der Tunnel bleibt nach dem Verlassen mit dieser Tastenabfolge weiterhin bestehen.
  
## Automatischer Start beim Booten

* per systemd
* https://transang.me/create-startup-scripts-in-ubuntu/

