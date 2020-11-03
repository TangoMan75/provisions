#!/bin/bash

#/**
# * install libre office writer
# *
# * @category office
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

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