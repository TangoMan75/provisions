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
# * install compizconfig
# *
# * @category nautilus
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

if [ "${GNOME}" = false ]; then
    echo_info 'sudo apt-get install -f'
    sudo apt-get install -f

    # compiz
    # compiz-core
    # compiz-plugins
    # compiz-plugins-extra
    # compizconfig-setttings-manager

    echo_info 'sudo apt-get install --assume-yes compizconfig-settings-manager'
    sudo apt-get install --assume-yes compizconfig-settings-manager

    echo_info 'sudo apt-get install compiz-plugins'
    sudo apt-get install compiz-plugins

    # temporary setup
    compiz --replace
else
    echo_error 'wrong system'
fi
