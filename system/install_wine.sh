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
# * wine
# *
# * windows emulator
# *
# * configure wine
# * `winecfg`
# *
# * wine virtual drive can be found here:
# * `~/.wine/drive_c`
# *
# * @link     https://wiki.winehq.org/Ubuntu
# * @category system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Wine'

# enable 32-bit architecture
echo_info 'sudo dpkg --add-architecture i386'
sudo dpkg --add-architecture i386

# install lib-32
echo_info 'sudo apt-get install --assume-yes lib32z1'
sudo apt-get install --assume-yes lib32z1

echo_info 'sudo apt-get install --assume-yes wine-stable'
sudo apt-get install --assume-yes wine-stable
