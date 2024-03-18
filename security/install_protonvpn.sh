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
# * protonvpn
# *
# * @category security
# * @link     https://protonvpn.com/support/official-linux-client
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install protonvpn'

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

# install key
echo_info 'wget -qO - https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add - '
wget -qO - https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add -

# add repository
echo_info "sudo add-apt-repository 'deb https://repo.protonvpn.com/debian unstable main'"
sudo add-apt-repository 'deb https://repo.protonvpn.com/debian unstable main'

# update repositories
echo_info 'sudo apt-get update'
sudo apt-get update

# install app
echo_info 'sudo apt-get install --assume-yes protonvpn'
sudo apt-get install --assume-yes protonvpn

alert_info 'How to use protonvpn'
echo_warning '  VPN'
echo_label   18 '    protonvpn-cli'; echo_primary 'login [ProtonVPN username]'
echo_label   18 '    protonvpn-cli'; echo_primary 'connect (or protonvpn-cli c)'
echo_label   18 '    protonvpn-cli'; echo_primary 'status (or protonvpn-cli s)'
echo_label   18 '    protonvpn-cli'; echo_primary 'disconnect (or protonvpn-cli d)'
echo
echo_warning '  Kill switch'
echo_label   18 '    protonvpn-cli'; echo_primary 'ks --on'
echo_label   18 '    protonvpn-cli'; echo_primary 'ks --always-on'
echo_label   18 '    protonvpn-cli'; echo_primary 'ks --off'
echo

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/protonvpn-app.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/protonvpn-app.desktop "$(xdg-user-dir DESKTOP)"

