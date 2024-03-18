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
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

VERSION=0.19.2

alert_primary "Install freetube ${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info "wget \"https://github.com/FreeTubeApp/FreeTube/releases/download/v${VERSION}-beta/freetube_${VERSION}_amd64.deb\""
wget "https://github.com/FreeTubeApp/FreeTube/releases/download/v${VERSION}-beta/freetube_${VERSION}_amd64.deb"

echo_info "sudo dpkg -i \"freetube_${VERSION}_amd64.deb\""
sudo dpkg -i "freetube_${VERSION}_amd64.deb"

echo_info "rm \"freetube_${VERSION}_amd64.deb\""
rm "freetube_${VERSION}_amd64.deb"

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/freetube.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/freetube.desktop "$(xdg-user-dir DESKTOP)"

