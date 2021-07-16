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
# * winmax
# * french online poker game
# *
# * @category games
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/system/is_installed.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

if [ ! -x "$(command -v wine)" ]; then
    echo_error "\"$(basename "${0}")\" requires wine, try: 'sudo apt-get install -y wine'"
    exit 1
fi

echo_primary 'please check wine version is >= 1.6.2'
echo_info 'wine --version'
wine --version

echo_primary 'please check wine is Windows 10 mode (optional)'
echo_info 'winecfg'
winecfg

echo_info 'wget https://dl.winamax.fr/client/windows/installer/wamInstall.exe'
wget https://dl.winamax.fr/client/windows/installer/wamInstall.exe

echo_info 'wine wamInstall.exe'
wine wamInstall.exe

echo_info 'rm -f wamInstall.exe'
rm -f wamInstall.exe

