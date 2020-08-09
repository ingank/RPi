## IPv6 Privacy Extensions (wieder) aktivieren

Durch das radikale Löschen der originalen /etc/dhcpcd.conf weiter oben in diesem
Tutorial, wurden auch die IPv6 Privacy Extensions vorübergehend auch wegrationalisiert.
Die (Wieder-) Aktivierung stellt jedoch keine große Hürde dar:
```
$ sudo su
> echo slaac private >> /etc/dhcpcd.conf
> systemctl daemon-reload
> systemctl restart dhcpcd
> exit
```
