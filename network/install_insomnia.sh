#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## insomnia
##
## API Rest client alternative to postman
##
## @category network
## @link     https://insomnia.rest

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

REPOSITORY=kong/insomnia
RELEASE=core@2023.2.2
VERSION=$(echo "${RELEASE}" | cut -d@ -f2)
FILENAME=Insomnia.Core-${VERSION}.deb

alert_primary "Install Insomnia v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

echo_info "wget -q \"https://github.com/${REPOSITORY}/releases/download/${RELEASE}/${FILENAME}\"\n"
wget -q "https://github.com/${REPOSITORY}/releases/download/${RELEASE}/${FILENAME}"

echo_info "sudo dpkg --install \"${FILENAME}\"\n"
sudo dpkg --install "${FILENAME}"

echo_info "rm -f \"${FILENAME}\"\n"
rm -f "${FILENAME}"

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/insomnia.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/insomnia.desktop "$(xdg-user-dir DESKTOP)"

