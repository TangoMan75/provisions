#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## woeusb
##
## create bootable usb drives
##
## @category system

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=woeusb
APP_NAME_2=woeusb-frontend-wxgtk
PPA=ppa:tomtomtom/woeusb

alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ -n "${PPA}" ]; then
    echo_info "sudo add-apt-repository --yes \"${PPA}\"\n"
    sudo add-apt-repository --yes "${PPA}"

    echo_info 'sudo apt-get update\n'
    sudo apt-get update
fi

#--------------------------------------------------

echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

echo_info "sudo apt-get install --assume-yes \"${APP_NAME_2}\"\n"
sudo apt-get install --assume-yes "${APP_NAME_2}"

