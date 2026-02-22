#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## monero-gui
##
## monero wallet
##
## @category crypto
## @link     https://getmonero.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install monero'

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

# download the apt signing key
_echo_info 'wget -q https://www.whonix.org/derivative.asc\n'
wget -q https://www.whonix.org/derivative.asc

# add the apt signing key
_echo_info 'sudo mv -fv ./derivative.asc /usr/share/keyrings/derivative.asc\n'
sudo mv -fv ./derivative.asc /usr/share/keyrings/derivative.asc

# add the derivative repository
_echo_info 'echo "deb [signed-by=/usr/share/keyrings/derivative.asc] https://deb.whonix.org bullseye main contrib non-free" | sudo tee /etc/apt/sources.list.d/derivative.list\n'
echo "deb [signed-by=/usr/share/keyrings/derivative.asc] https://deb.whonix.org bullseye main contrib non-free" | sudo tee /etc/apt/sources.list.d/derivative.list

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install monero-gui\n'
sudo apt-get install monero-gui

# create shortcut on desktop
_echo_info "cp -p /usr/share/applications/monero-gui.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/monero-gui.desktop "$(xdg-user-dir DESKTOP)"

