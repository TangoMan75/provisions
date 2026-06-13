#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## protonvpn
##
## @category security
## @link     https://protonvpn.com/fr/support/official-linux-vpn-ubuntu

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=proton-vpn-gnome-desktop
DESKTOP=proton.vpn.app.gtk.desktop
RELEASE_PKG=protonvpn-stable-release_1.0.8_all.deb
RELEASE_URL="https://repo.protonvpn.com/debian/dists/stable/main/binary-all/${RELEASE_PKG}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

#--------------------------------------------------

# Download and install the repository package
_echo_info "wget \"${RELEASE_URL}\"\n"
wget "${RELEASE_URL}"

_echo_info "sudo dpkg -i \"${RELEASE_PKG}\"\n"
sudo dpkg -i "${RELEASE_PKG}"

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

# cleanup downloaded package
_echo_info "rm -f \"${RELEASE_PKG}\"\n"
rm -f "${RELEASE_PKG}"

#--------------------------------------------------

# install app
_echo_info "sudo apt-get install --assume-yes ${APP_NAME}\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

# install system tray icon (optional)
_echo_info 'sudo apt-get install --assume-yes gnome-shell-extension-appindicator\n'
sudo apt-get install --assume-yes gnome-shell-extension-appindicator

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"
