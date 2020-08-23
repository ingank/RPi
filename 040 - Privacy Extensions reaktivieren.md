## IPv6 Privacy Extensions (wieder) aktivieren

Bei der strikten Befolgung der in den vorherigen Kapiteln beschriebenen Arbeitsschritte werden zwangsläufig die IPv6 Privacy Extensions
des RasperryPi deaktiviert. Die (Wieder-) Aktivierung stellt jedoch keine große Hürde dar:
```
$ sudo su
> echo slaac private >> /etc/dhcpcd.conf
> systemctl daemon-reload
> systemctl restart dhcpcd
> exit
```
