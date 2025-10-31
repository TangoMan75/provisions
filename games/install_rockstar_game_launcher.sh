#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Rockstar Game Launcher
##
## @category games
## @link     https://socialclub.rockstargames.com/rockstar-games-launcher
## @link     https://lutris.net/games/rockstar-games-launcher/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary "Install Rockstar Game Launcher"

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v wine)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wine, try: 'sudo apt-get install -y wine'\n"
    exit 1
fi

if [ ! -x "$(command -v lutris)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires lutris, try: 'sudo apt-get install -y lutris'\n"
    exit 1
fi

echo_info 'Download Rockstar Game Launcher Lutris config\n'

echo_info 'wget -O /tmp/rockstar-games-launcher-standalone-1036344.json https://lutris.net/api/installers/rockstar-games-launcher-standalone-1036344?format=json\n'
wget -O /tmp/rockstar-games-launcher-standalone-1036344.json https://lutris.net/api/installers/rockstar-games-launcher-standalone-1036344?format=json

echo_info 'Installing Rockstar Game Launcher from Lutris config\n'
echo_warning 'If installation fails try to config wine with "winecfg"'

echo_info 'lutris -i /tmp/rockstar-games-launcher-standalone-1036344.json\n'
lutris -i /tmp/rockstar-games-launcher-standalone-1036344.json
