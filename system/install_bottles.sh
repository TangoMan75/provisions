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
# * bottles
# *
# * Run Windows softwares
# *
# * @category system
# * @link     https://usebottles.com
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Bottles'

if [ ! -x "$(command -v flatpak)" ]; then
    echo_error "\"$(basename "${0}")\" requires flatpak, try: 'sudo apt-get install -y flatpak'"
    exit 1
fi

echo_info 'sudo flatpak install -y flathub com.usebottles.bottles'
sudo flatpak install -y flathub com.usebottles.bottles

echo_warning 'You need to reboot your system for the change to take effect'
