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
# * insomnia
# *
# * API Rest client alternative to postman
# *
# * @category network
# * @link     https://insomnia.rest
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

REPOSITORY=kong/insomnia
RELEASE=$(get_latest_release "${REPOSITORY}")
if [ -z "${RELEASE}" ]; then
    RELEASE=core@2021.3.0
fi
VERSION=$(echo "${RELEASE}" | cut -d@ -f2)
FILENAME=Insomnia.Core-${VERSION}.deb

alert_primary "Install Insomnia v${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info "wget -q \"https://github.com/${REPOSITORY}/releases/download/${RELEASE}/${FILENAME}\""
wget -q "https://github.com/${REPOSITORY}/releases/download/${RELEASE}/${FILENAME}"

echo_info "sudo dpkg -i \"${FILENAME}\""
sudo dpkg -i "${FILENAME}"

echo_info "rm -f \"${FILENAME}\""
rm -f "${FILENAME}"

# create desktop shortcut
cat > ~/Desktop/insomnia.desktop<<EOF
[Desktop Entry]
Name=Insomnia
Exec=/opt/Insomnia/insomnia %U
Terminal=false
Type=Application
Icon=insomnia
StartupWMClass=Insomnia
Comment=The Collaborative API Design Tool
MimeType=x-scheme-handler/insomnia;
Categories=Development;
EOF
