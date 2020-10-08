# Konfiguration ''out of the box''

Der RasPi kann ohne Bildschirm und Eingabegeräte betrieben werden (Headless).
Dazu müssen grundlegende Funktionen direkt auf dem Betriebssystemdatenträger (out of the box) konfiguriert werden.

Vorbereitend binden wir in einem beliebigen Linux-Laufwerksmanager die Partition mit dem Bezeichner 'boot' in den Dateibaum ein (mounten).

Danach öffnen wir ein Terminal im Hauptverzeichnis dieser Partition.

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

Weiterführende Informationen zum Kernel-Paramter __ip__:
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
