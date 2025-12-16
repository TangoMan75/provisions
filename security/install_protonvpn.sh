#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
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
DESKTOP=protonvpn-app.desktop

alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

#--------------------------------------------------

# install key
echo_info 'wget -qO - https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add - \n'
wget -qO - https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add -

#--------------------------------------------------

if [ -n "${PPA}" ]; then
    echo_info "sudo add-apt-repository --yes \"${PPA}\"\n"
    sudo add-apt-repository --yes "${PPA}"

    echo_info 'sudo apt-get update\n'
    sudo apt-get update
fi

#--------------------------------------------------

# install app
echo_info 'sudo apt-get install --assume-yes protonvpn\n'
sudo apt-get install --assume-yes protonvpn

#--------------------------------------------------

# alert_info 'How to use protonvpn\n'
# echo_warning 'VPN\n' 2
# echo_success 'protonvpn-cli' 4 16; echo_primary 'login [ProtonVPN username]\n'
# echo_success 'protonvpn-cli' 4 16; echo_primary 'connect (or protonvpn-cli c)\n'
# echo_success 'protonvpn-cli' 4 16; echo_primary 'status (or protonvpn-cli s)\n'
# echo_success 'protonvpn-cli' 4 16; echo_primary 'disconnect (or protonvpn-cli d)\n'
# echo
# echo_warning 'Kill switch\n' 2
# echo_success 'protonvpn-cli' 4 16; echo_primary 'ks --on\n'
# echo_success 'protonvpn-cli' 4 16; echo_primary 'ks --always-on\n'
# echo_success 'protonvpn-cli' 4 16; echo_primary 'ks --off\n'
# echo

#--------------------------------------------------

# create shortcut on desktop
echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"
