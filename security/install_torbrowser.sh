#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * tor browser
# *
# * @link     https://flathub.org/apps/org.torproject.torbrowser-launcher
# * @category security
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install torbrowser'

if [ ! -x "$(command -v flatpak)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires flatpak\n"
    exit 1
fi

echo_info 'flatpak install flathub org.torproject.torbrowser-launcher -y\n'
flatpak install flathub org.torproject.torbrowser-launcher -y

