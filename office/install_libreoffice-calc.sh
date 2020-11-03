#!/bin/bash

#/**
# * install libre office calc
# *
# * @category office
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

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
