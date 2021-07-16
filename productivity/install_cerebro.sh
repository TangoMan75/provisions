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
# * cerebro
# *
# * @category productivity
# * @link     https://cerebroapp.com
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

REPOSITORY=cerebroapp/cerebro
VERSION=0.3.2
FILENAME=cerebro_${VERSION}_amd64.deb

alert_primary "Install Cerebro v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info "wget -q \"https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${FILENAME}\""
wget -q "https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${FILENAME}"

echo_info "sudo dpkg -i \"${FILENAME}\""
sudo dpkg -i "${FILENAME}"

echo_info "rm -f \"${FILENAME}\""
rm -f "${FILENAME}"

echo_info 'sudo apt-get install -f'
sudo apt-get install -f

# create desktop shortcut
cat > ~/Desktop/cerebro.desktop<<EOF
[Desktop Entry]
Name=Cerebro
Comment=Extendable electron-based open-source Spolight and Alfred analogue
Exec="/opt/Cerebro/cerebro"
Terminal=false
Type=Application
Icon=cerebro
Categories=Utility;
EOF
