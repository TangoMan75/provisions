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
# * nautilus-actions
# * add custom actions to file manager context menus
# *
# * @category nautilus
# * @link     http://www.nautilus-actions.org
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

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
    echo_info 'sudo apt-get install --assume-yes nautilus-actions'
    sudo apt-get install --assume-yes nautilus-actions
else
    echo_error 'wrong system'
fi
