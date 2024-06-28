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
# * chrome
# * web browser
# *
# * @category browser
# * @url      https://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-stable
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

VERSION=115.0.5790.110-1

alert_primary "Install Chrome ${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info "wget \"https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${VERSION}_amd64.deb\""
wget "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${VERSION}_amd64.deb"

echo_info "sudo dpkg -i \"google-chrome-stable_${VERSION}_amd64.deb\""
sudo dpkg -i "google-chrome-stable_${VERSION}_amd64.deb"

echo_info "rm \"google-chrome-stable_${VERSION}_amd64.deb\""
rm "google-chrome-stable_${VERSION}_amd64.deb"

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/google-chrome.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/google-chrome.desktop "$(xdg-user-dir DESKTOP)"

