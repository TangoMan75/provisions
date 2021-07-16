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
# * @category kali
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

CONFIG_DIR="${CURDIR}/../config"

if [ "$(lsb_release -is 2>/dev/null)" = 'Kali' ]; then
    echo_info "dconf load /org/gnome/ < \"${CONFIG_DIR}/kali/dconf/org_gnome.conf\""
    dconf load /org/gnome/ < "${CONFIG_DIR}/kali/dconf/org_gnome.conf"
else
    echo_error 'wrong system version'
fi
