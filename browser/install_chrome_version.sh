#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## chrome
## web browser
##
## @category browser
## @url      https://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-stable

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

VERSION=115.0.5790.110-1

_alert_primary "Install Chrome ${VERSION}"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info "wget \"https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${VERSION}_amd64.deb\"\n"
wget "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${VERSION}_amd64.deb"

_echo_info "sudo dpkg --install \"google-chrome-stable_${VERSION}_amd64.deb\"\n"
sudo dpkg --install "google-chrome-stable_${VERSION}_amd64.deb"

_echo_info "rm \"google-chrome-stable_${VERSION}_amd64.deb\"\n"
rm "google-chrome-stable_${VERSION}_amd64.deb"

# create shortcut on desktop
_echo_info "cp -p /usr/share/applications/google-chrome.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/google-chrome.desktop "$(xdg-user-dir DESKTOP)"

