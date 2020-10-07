# Tweaks

## Swap-Speicher vergrößern

Als Benutzer mit root-Rechten ausführen:

```
nano /etc/dphys-swapfile
```

Die voreingestellte Größe des Auslagerungsspeichers:

```
CONF_SWAPSIZE=100
```

Ändern in:

```
CONF_SWAPSIZE=2048
```

[Strg]+[S] und [Strg]+[X] zum Speichern und Beenden drücken.

Danach den Systemdienst dphys-swapfile neu starten:
```
/etc/init.d/dphys-swapfile stop
/etc/init.d/dphys-swapfile start
```
