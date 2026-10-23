#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## winehq
##
## windows emulator
##
## configure wine
## `winecfg`
##
## wine virtual drive can be found here:
## `~/.wine/drive_c`
##
## @category system
## @note     this is the recommended version for ubuntu

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install Wine HQ'

# enable 32-bit architecture
_echo_info 'sudo dpkg --add-architecture i386\n'
sudo dpkg --add-architecture i386

# install lib-32
_echo_info 'sudo apt-get install --assume-yes lib32z1\n'
sudo apt-get install --assume-yes lib32z1

if [ -z "$(lsb_release -cs 2>/dev/null)" ]; then
    _echo_danger 'error: wrong system'
    exit 1
fi

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info 'sudo mkdir -p -pm755 /etc/apt/keyrings\n'
sudo mkdir -p -pm755 /etc/apt/keyrings

_echo_info 'sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key\n'
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

_echo_info "sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$(lsb_release -cs)/winehq-$(lsb_release -cs).sources\n"
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/"$(lsb_release -cs)"/winehq-"$(lsb_release -cs)".sources

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt --assume-yes install winehq-stable\n'
sudo apt --assume-yes install winehq-stable

# _echo_info 'sudo apt --assume-yes install wine-stable\n'
# sudo apt --assume-yes install wine-stable

