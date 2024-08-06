#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * freetube
# *
# * @category multimedia
# * @link     https://freetubeapp.io/#download
# * @link     https://github.com/FreeTubeApp/FreeTube/releases
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

BASENAME=freetube
REPOSITORY=FreeTubeApp/FreeTube
VERSION=0.20.0
FILENAME=${BASENAME}_${VERSION}_amd64.deb

alert_primary "Install ${BASENAME} ${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info "wget \"https://github.com/${REPOSITORY}/releases/download/v${VERSION}-beta/${FILENAME}\""
wget "https://github.com/${REPOSITORY}/releases/download/v${VERSION}-beta/${FILENAME}"

echo_info "sudo dpkg -i \"${FILENAME}\""
sudo dpkg -i "${FILENAME}"

echo_info "rm \"${FILENAME}\""
rm "${FILENAME}"

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/freetube.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/freetube.desktop "$(xdg-user-dir DESKTOP)"

