#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config org_gnome
##
## @category system

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

# check system uses gnome
if [ "${XDG_CURRENT_DESKTOP}" != 'ubuntu:GNOME' ]; then
    RELEASE="$(lsb_release -cs 2>/dev/null)"
    _echo_danger "error: ${RELEASE} not supported\n"

    exit 1
fi

_echo_info "dconf load /org/gnome/ < \"${CONFIG_DIR}/gnome/dconf/org_gnome.conf\"\n"
dconf load /org/gnome/ < "${CONFIG_DIR}/gnome/dconf/org_gnome.conf"
