#!/bin/bash

#/**
# * firefox
# * web browser
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes firefox'
sudo apt-get install --assume-yes firefox

# create desktop shortcut
cat > ~/Desktop/virtualbox.desktop<<EOF
[Desktop Entry]
Version=1.0
Name=Firefox Web Browser
Comment=Browse the World Wide Web
GenericName=Web Browser
Keywords=Internet;WWW;Browser;Web;Explorer
Exec=firefox %u
Terminal=false
Type=Application
Icon=firefox
Categories=GNOME;GTK;Network;WebBrowser;
StartupNotify=true
EOF
