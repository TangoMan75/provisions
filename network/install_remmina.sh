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
# * remmina
# * remote desktop client
# *
# * @category network
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install remmina'

echo_info 'sudo apt-get install --assume-yes remmina'
sudo apt-get install --assume-yes remmina

# create desktop shortcut
cat > ~/Desktop/org.remmina.Remmina.desktop<<EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=org.remmina.Remmina
Exec=remmina-file-wrapper %U
Name=Remmina
Comment=Connect to remote desktops
EOF
