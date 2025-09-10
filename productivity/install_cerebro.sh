#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## cerebro
##
## App launcher
##
## @category productivity
## @link     https://cerebroapp.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

REPOSITORY=cerebroapp/cerebro
VERSION=0.11.0
FILENAME=cerebro_${VERSION}_amd64.deb

alert_primary "Install Cerebro v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

echo_info "wget -q \"https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${FILENAME}\"\n"
wget -q "https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${FILENAME}"

echo_info "sudo dpkg --install \"${FILENAME}\"\n"
sudo dpkg --install "${FILENAME}"

echo_info "rm -f \"${FILENAME}\"\n"
rm -f "${FILENAME}"

echo_info 'sudo apt-get install -f\n'
sudo apt-get install -f

# create desktop shortcut
cat > "$(xdg-user-dir DESKTOP)"/cerebro.desktop<<EOF
[Desktop Entry]
Name=Cerebro
Comment=Extendable electron-based open-source Spolight and Alfred analogue
Exec="/opt/Cerebro/cerebro"
Terminal=false
Type=Application
Icon=cerebro
Categories=Utility;
EOF
