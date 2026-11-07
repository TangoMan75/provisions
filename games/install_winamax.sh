#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## winmax
## french online poker game
##
## @category games

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/system/is_installed.sh"

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v wine)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wine, try: 'sudo apt-get install -y wine'\n"
    exit 1
fi

_echo_primary 'please check wine version is >= 1.6.2\n'
_echo_info 'wine --version\n'
wine --version

_echo_primary 'please check wine is Windows 10 mode (optional)\n'
_echo_info 'winecfg\n'
winecfg

_echo_info 'wget https://dl.winamax.fr/client/windows/installer/wamInstall.exe\n'
wget https://dl.winamax.fr/client/windows/installer/wamInstall.exe

_echo_info 'wine wamInstall.exe\n'
wine wamInstall.exe

_echo_info 'rm -f wamInstall.exe\n'
rm -f wamInstall.exe

