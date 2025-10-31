#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Blizzard Battle.net
##
## @category games
## @link     https://www.blizzard.com/en-us/download
## @link     https://github.com/lutris/docs/blob/master/Battle.Net.md
## @link     https://lutris.net/games/battlenet/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary "Install Blizzard Battle.net"

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

echo_info 'Download Blizzard Battle.net Lutris config\n'

echo_info 'wget -O /tmp/blizzard-battlenet-standard.json https://lutris.net/api/installers/blizzard-battlenet-standard?format=json\n'
wget -O /tmp/blizzard-battlenet-standard.json https://lutris.net/api/installers/blizzard-battlenet-standard?format=json

echo_info 'Installing Blizzard Battle.net from Lutris config\n'
echo_warning 'If installation fails try to config wine with "winecfg"'

echo_info 'lutris -i /tmp/blizzard-battlenet-standard.json\n'
lutris -i /tmp/blizzard-battlenet-standard.json
