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
# * install libre office calc
# *
# * @category office
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install libreoffice-calc'

echo_info 'sudo apt-get install --assume-yes libreoffice-calc'
sudo apt-get install --assume-yes libreoffice-calc

# create desktop shortcut
cat > ~/Desktop/libreoffice-calc.desktop<<EOF
[Desktop Entry]
Version=1.0
Terminal=false
Icon=libreoffice-calc
Type=Application
Categories=Office;Spreadsheet;
Exec=libreoffice --calc %U
Name=LibreOffice Calc
GenericName=Spreadsheet
Comment=Perform calculations, analyze information and manage lists in spreadsheets by using Calc.
StartupNotify=true
EOF
