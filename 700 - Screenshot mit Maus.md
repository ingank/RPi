# Screenshots mit Mauszeiger

- die deutsche Standardtaste für Screenshots ist `Druck // S-Abf`
- Screenshot mit Mauszeiger:
  - `sudo apt install gnome-screenshot`
  - `sudo nano /etc/xdg/openbox/lxde-pi-rc.xml`
  - `Strg` + `W`
  - Suchen nach: `<keybind key="Print">`
  - Zwischen `<command>` und `</command>` einfügen: `gnome-screenshot -p`
  - `Strg` + `X`
  - `Y`
  - `openbox --restart`
