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
# * Grand Theft Auto V
# *
# * @category games
# * @link     https://lutris.net/games/grand-theft-auto-v/
# * @link     https://www.rockstargames.com/gta-v
# * @link     https://socialclub.rockstargames.com/games/gtav
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Grand Theft Auto V'

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

if [ ! -x "$(command -v wine)" ]; then
    echo_error "\"$(basename "${0}")\" requires wine, try: 'sudo apt-get install -y wine'"
    exit 1
fi

if [ ! -x "$(command -v lutris)" ]; then
    echo_error "\"$(basename "${0}")\" requires lutris, try: 'sudo apt-get install -y lutris'"
    exit 1
fi

echo_info 'Download Grand Theft Auto V Lutris config'

echo_info 'wget -O /tmp/grand-theft-auto-v-rockstar-games-launc.json https://lutris.net/api/installers/grand-theft-auto-v-rockstar-games-launc?format=json'
wget -O /tmp/grand-theft-auto-v-rockstar-games-launc.json https://lutris.net/api/installers/grand-theft-auto-v-rockstar-games-launc?format=json

echo_info 'Installing Grand Theft Auto V from Lutris config'
echo_warning 'If installation fails try to config wine with "winecfg"'

echo_info 'lutris -i /tmp/grand-theft-auto-v-rockstar-games-launc.json'
lutris -i /tmp/grand-theft-auto-v-rockstar-games-launc.json
