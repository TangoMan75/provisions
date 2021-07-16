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
# * config org_gnome
# *
# * @category system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

CONFIG_DIR="${CURDIR}/../config"

# check system uses gnome
GNOME=false
RELEASE="$(lsb_release -cs)"
for CODENAME in bionic cosmic disco eoan focal kali
do
    if [ "${RELEASE}" = "${CODENAME}" ]; then
        GNOME=true
    fi
done

if [ "${GNOME}" = true ]; then
    echo_info "dconf load /org/gnome/ < \"${CONFIG_DIR}/gnome/dconf/org_gnome.conf\""
    dconf load /org/gnome/ < "${CONFIG_DIR}/gnome/dconf/org_gnome.conf"
else
    echo_error "${RELEASE} not supported"
fi
