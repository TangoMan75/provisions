#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>>

# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * zenmap
# * nmap network scanner graphic interface
# *
# * @category network
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

PYTHON_GTK2=python-gtk2_2.24.0-5.1ubuntu2_amd64.deb
ZENMAP=zenmap_7.60-1ubuntu5_all.deb

alert_primary "Install $(basename "${ZENMAP}" .deb)"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

if [ ! -x "$(command -v nmap)" ]; then
    echo_error "\"$(basename "${0}")\" requires nmap, try: 'sudo apt-get install -y nmap'"
    exit 1
fi

echo_info "wget \"http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/${PYTHON_GTK2}\""
wget "http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/${PYTHON_GTK2}"

echo_info "wget \"http://archive.ubuntu.com/ubuntu/pool/universe/n/nmap/${ZENMAP}\""
wget "http://archive.ubuntu.com/ubuntu/pool/universe/n/nmap/${ZENMAP}"

echo_info "sudo apt-get install --assume-yes ./\"${PYTHON_GTK2}\""
sudo apt-get install --assume-yes ./"${PYTHON_GTK2}"

echo_info "sudo apt-get install --assume-yes ./\"${ZENMAP}\""
sudo apt-get install --assume-yes ./"${ZENMAP}"

echo_info "rm -f \"./${PYTHON_GTK2}\""
rm -f "./${PYTHON_GTK2}"

echo_info "rm -f \"./${ZENMAP}\""
rm -f "./${ZENMAP}"

# create desktop shortcut
cat > ~/Desktop/zenmap.desktop<<EOF
[Desktop Entry]
Name=Zenmap
GenericName=GUI Port Scanner
TryExec=zenmap
Exec=zenmap %F
Terminal=false
Icon=/usr/share/zenmap/pixmaps/zenmap.png
Type=Application
Categories=Application;Network;Security;
Comment=A cross-platform GUI for the Nmap Security Scanner.
Keywords=network;scan;scanner;IP;security;
EOF

cat > ~/Desktop/zenmap-root.desktop<<EOF
[Desktop Entry]
Name=Zenmap (as root)
GenericName=GUI Port Scanner
TryExec=su-to-root
Exec=su-to-root -X -c zenmap %F
Terminal=false
Icon=/usr/share/zenmap/pixmaps/zenmap.png
Type=Application
Categories=Application;Network;Security;
Comment=A cross-platform GUI for the Nmap Security Scanner.
Keywords=network;scan;scanner;IP;security;
EOF
