#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove grub-customizer
##
## @category system

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

APP_NAME=grub-customizer
PPA=ppa:danielrichter2007/grub-customizer

alert_danger "Remove ${APP_NAME}"

# --------------------------------------------------

echo_info "sudo apt-get purge --assume-yes \"${APP_NAME}\"\n"
sudo apt-get purge --assume-yes "${APP_NAME}"

# --------------------------------------------------

echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

# --------------------------------------------------

if [ -n "${PPA}" ]; then
    echo_info "sudo add-apt-repository --remove --yes \"${PPA}\"\n"
    sudo add-apt-repository --remove --yes "${PPA}"

    echo_info 'sudo apt-get update\n'
    sudo apt-get update
fi
