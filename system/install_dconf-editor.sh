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
# * dconf-editor
# *
# * enable advanced gnome configuration
# *
# * @category system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"


# check system uses gnome
GNOME=false
RELEASE="$(lsb_release -cs 2>/dev/null)"
for CODENAME in bionic cosmic disco eoan focal jammy kali
do
    if [ "${RELEASE}" = "${CODENAME}" ]; then
        GNOME=true
    fi
done

if [ "${GNOME}" = true ]; then
    echo_info 'sudo apt-get install --assume-yes dconf-editor'
    sudo apt-get install --assume-yes dconf-editor
else
    echo_error "${RELEASE} not supported"
fi
