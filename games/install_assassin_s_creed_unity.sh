#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Assassin's Creed Unity
##
## @category games
## @link     https://ubisoftconnect.com
## @link     https://lutris.net/games/assassins-creed-unity/
## @link     https://lutris.net/games/ubisoft-connect/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary "Install Assassin's Creed Unity"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v wine)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wine, try: 'sudo apt-get install -y wine'\n"
    exit 1
fi

if [ ! -x "$(command -v lutris)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires lutris, try: 'sudo apt-get install -y lutris'\n"
    exit 1
fi

_echo_info "Download Assassin's Creed Unity Lutris config\n"

_echo_info 'wget -O /tmp/assassins-creed-unity-uplay.json https://lutris.net/api/installers/assassins-creed-unity-uplay?format=json\n'
wget -O /tmp/assassins-creed-unity-uplay.json https://lutris.net/api/installers/assassins-creed-unity-uplay?format=json

_echo_info "Installing Assassin's Creed from Lutris config\n"
_echo_warning 'If installation fails try to config wine with "winecfg"'

_echo_info 'lutris -i /tmp/assassins-creed-unity-uplay.json\n'
lutris -i /tmp/assassins-creed-unity-uplay.json

# _alert_danger "Cannot install Assassin's Creed Unity"
