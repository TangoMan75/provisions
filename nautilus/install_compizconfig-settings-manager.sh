#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install compizconfig
##
## @category nautilus

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# check system does not use gnome
if [ "${XDG_CURRENT_DESKTOP}" = 'ubuntu:GNOME' ]; then
    RELEASE="$(lsb_release -cs 2>/dev/null)"
    echo_danger "error: ${RELEASE} not supported\n"

    exit 1
fi

echo_info 'sudo apt-get install -f\n'
sudo apt-get install -f

# compiz
# compiz-core
# compiz-plugins
# compiz-plugins-extra
# compizconfig-setttings-manager

echo_info 'sudo apt-get install --assume-yes compizconfig-settings-manager\n'
sudo apt-get install --assume-yes compizconfig-settings-manager

echo_info 'sudo apt-get install compiz-plugins\n'
sudo apt-get install compiz-plugins

# temporary setup
compiz --replace
