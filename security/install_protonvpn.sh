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
## @link     https://protonvpn.com/support/official-linux-client

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=protonvpn
PPA='deb https://repo.protonvpn.com/debian unstable main'
DESKTOP=proton.vpn.app.gtk.desktop

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

#--------------------------------------------------

# install key
_echo_info 'wget -qO - https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add - \n'
wget -qO - https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add -

#--------------------------------------------------

if [ -n "${PPA}" ]; then
    _echo_info "sudo add-apt-repository --yes \"${PPA}\"\n"
    sudo add-apt-repository --yes "${PPA}"

    _echo_info 'sudo apt-get update\n'
    sudo apt-get update
fi

#--------------------------------------------------

# install app
_echo_info 'sudo apt-get install --assume-yes protonvpn\n'
sudo apt-get install --assume-yes protonvpn

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"
