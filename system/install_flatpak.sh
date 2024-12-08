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
# * flatpak
# *
# * Linux packaging tool
# *
# * @category system
# * @link     https://doc.ubuntu-fr.org/flatpak
# * @link     https://flathub.org/apps
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Flatpack'

echo_info 'sudo apt-get install --assume-yes flatpak\n'
sudo apt-get install --assume-yes flatpak

echo_info 'sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo\n'
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
