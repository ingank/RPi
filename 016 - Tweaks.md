# Tweaks

## Swap-Speicher vergrößern

Um die voreingestellte Größe des Auslagerungsspeichers zu verändern,
müssen folgende Aktionen **als Benutzer mit root-Rechten** ausgeführt werden:

`nano /etc/dphys-swapfile`

Raspbian hat standardmäßig einen Auslagerungsspeicher von 100 Megabyte.
fr Ressourcen hungrige Applikationen sollte der Auslagerungsspeicher vergrert werden

Raspbian has 100MB of swap by default.
You should change it to 2048MB in the configuration file.
So you will have to find this line:

`CONF_SWAPSIZE=100`

And then change it into:

`CONF_SWAPSIZE=2048`

Press [Strg]+[S] to save changes and [Strg]+[X] to close the nano-editor.
Then restart dphys-swapfile to apply changes:

/etc/init.d/dphys-swapfile stop
/etc/init.d/dphys-swapfile start
