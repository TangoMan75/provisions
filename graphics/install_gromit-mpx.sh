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
# * @link     https://flathub.org/apps/net.christianbeier.Gromit-MPX
# * @link     https://github.com/bk138/gromit-mpx
# * @category graphics
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Gromit-MPX'

if [ ! -x "$(command -v flatpak)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires flatpak\n"
    exit 1
fi

echo_info 'flatpak install flathub net.christianbeier.Gromit-MPX -y\n'
flatpak install flathub net.christianbeier.Gromit-MPX -y
