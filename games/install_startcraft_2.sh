#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Starcraft II
##
## @category games
## @link     https://lutris.net/games/starcraft-ii

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Install Starcraft II'

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

echo_info 'Installing Lutris Battle.net prerequisintes\n'

echo_info 'sudo apt-get install --assume-yes libgnutls30:i386\n'
sudo apt-get install --assume-yes libgnutls30:i386

echo_info 'sudo apt-get install --assume-yes libldap-2.4-2:i386\n'
sudo apt-get install --assume-yes libldap-2.4-2:i386

echo_info 'sudo apt-get install --assume-yes libgpg-error0:i386\n'
sudo apt-get install --assume-yes libgpg-error0:i386

echo_info 'sudo apt-get install --assume-yes libsqlite3-0:i386\n'
sudo apt-get install --assume-yes libsqlite3-0:i386

echo_info 'Download Startcraft II Lutris config\n'

echo_info 'wget -O /tmp/starcraft2-lutris.json https://lutris.net/api/installers/starcraft-ii-battlenet?format=json\n'
wget -O /tmp/starcraft2-lutris.json https://lutris.net/api/installers/starcraft-ii-battlenet?format=json

echo_info 'Installing Startcraft II from Lutris config\n'
echo_warning 'If installation fails try to config wine with "winecfg"'

echo_info 'lutris -i /tmp/starcraft2-lutris.json\n'
lutris -i /tmp/starcraft2-lutris.json

