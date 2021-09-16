# RaspiOS auf VBox

## Auflösung einstellen

```
xrandr --newmode "1920x1080"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode Virtual1 1920x1080
```

## GuestAdditions installieren

```
sudo apt install build-essential module-assistant dkms
sudo m-a prepare
```

add the vbox additions iso ( settings/storage/optical drive - vboxadditons.iso)

```
sudo sh /media/cdrom/VBoxLinuxAdditions.run
sudo reboot now
```
