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
# * install libre office writer
# *
# * @category office
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install libreoffice-writer'

echo_info 'sudo apt-get install --assume-yes libreoffice-writer'
sudo apt-get install --assume-yes libreoffice-writer

# create desktop shortcut
cat > ~/Desktop/libreoffice-writer.desktop<<EOF
[Desktop Entry]
Version=1.0
Terminal=false
Icon=libreoffice-writer
Type=Application
Categories=Office;Spreadsheet;
Exec=libreoffice --writer %U
Name=LibreOffice Writer
GenericName=Word Processor
Comment=Create and edit text and graphics in letters, reports, documents and Web pages by using Writer.
StartupNotify=true
EOF