
Debian
====================
This directory contains files used to package goacoind/goacoin-qt
for Debian-based Linux systems. If you compile goacoind/goacoin-qt yourself, there are some useful files here.

## goacoin: URI support ##


goacoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install goacoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your goacoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/goacoin128.png` to `/usr/share/pixmaps`

goacoin-qt.protocol (KDE)

