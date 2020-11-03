#!/bin/bash

#/**
# * tor browser
# *
# * @category security
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes torbrowser-launcher'
sudo apt-get install --assume-yes torbrowser-launcher

# create desktop shortcut
cat > ~/Desktop/torbrowser.desktop<<EOF
[Desktop Entry]
Name=Tor Browser
GenericName=Tor browser
Comment=Launch Tor Browser
Exec=torbrowser-launcher %u
Terminal=false
Type=Application
Icon=torbrowser
Categories=Network;WebBrowser;
EOF
