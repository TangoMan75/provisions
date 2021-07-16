#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * wine
# * windows emulator
# *
# * configure wine
# * `winecfg`
# *
# * wine virtual drive can be found here:
# * `~/.wine/drive_c`
# *
# * @category system
# * @note     this is the recommended version for ubuntu
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# enable 32-bit architecture
echo_info 'sudo dpkg --add-architecture i386'
sudo dpkg --add-architecture i386

if [ -z "$(lsb_release -cs 2>/dev/null)" ]; then
    echo_error 'wrong system'
    exit 1
fi

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info 'wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -'
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -

echo_info "sudo apt-add-repository \"deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs) main\""
sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs) main"

echo_info 'sudo apt-get update'
sudo apt-get update

# winehq requires aptitude to install for some reason
echo_info 'sudo apt-get install --assume-yes aptitude'
sudo apt-get install --assume-yes aptitude

# echo_info 'sudo apt-get --assume-yes install --install-recommends winehq-stable'
# sudo apt-get --assume-yes install --install-recommends winehq-stable

echo_info 'sudo aptitude install -y winehq-stable'
sudo aptitude install -y winehq-stable

