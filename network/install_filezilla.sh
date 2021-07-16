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
# * filezilla
# *
# * ftp client
# *
# * @category network
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install filezilla'

echo_info 'sudo apt-get install --assume-yes filezilla'
sudo apt-get install --assume-yes filezilla

# create desktop shortcut
cat > ~/Desktop/filezilla.desktop<<EOF
[Desktop Entry]
Name=FileZilla
GenericName=FTP client
Comment=Download and upload files via FTP, FTPS and SFTP
Exec=filezilla
Terminal=false
Icon=filezilla
Type=Application
Categories=Network;FileTransfer;
Version=1.0
EOF

