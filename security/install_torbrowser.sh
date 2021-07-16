#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * tor browser
# *
# * @category security
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

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
