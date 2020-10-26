# Software (kleine Übersicht)

## Vor dem Installieren
```
sudo apt update
sudo apt upgrade
```
## Software installieren und konfigurieren

### mc (Midnight Commander)
```
sudo apt install mc
```

### vscode/headmelted (Entwicklungsumgebung)
```
sudo su
wget -qO - https://packagecloud.io/headmelted/codebuilds/gpgkey | sudo apt-key add -
bash <( wget -O - https://code.headmelted.com/installers/apt.sh )
Plugins: GitLens, GitHistory, ...
```

### ungit

Ungit benötigt NodeJS.
```
sudo su
curl -sL https://deb.nodesource.com/setup_lts.x | bash -
apt-get install -y nodejs
sudo -H npm install -g ungit
```

Ungit-Server starten:
```
ungit
```

Standard-Adresse der ungit-Website:
```
http://localhost:8448/`
```
