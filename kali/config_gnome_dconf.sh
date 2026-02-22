#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config org_gnome
##
## @category kali

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_secondary 'Config dconf'

if [ ! -x "$(command -v dconf)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires dconf, try: 'sudo apt-get install -y dconf-editor'\n"
    exit 1
fi

CONFIG_DIR="${CURDIR}/../config"

if [ "$(lsb_release -is 2>/dev/null)" = 'Kali' ]; then
    _echo_info "dconf load /org/gnome/ < \"${CONFIG_DIR}/kali/dconf/org_gnome.conf\"\n"
    dconf load /org/gnome/ < "${CONFIG_DIR}/kali/dconf/org_gnome.conf"
else
    _echo_danger 'error: wrong system version'
fi
